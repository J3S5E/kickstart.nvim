return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local harpoon = require 'harpoon'
    local extensions = require 'harpoon.extensions'

    harpoon:extend(extensions.builtins.highlight_current_file())

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local function filter_empty_string(list)
        local next = {}
        for idx = 1, #list do
          if list[idx] == nil then
            goto continue
          end
          if list[idx].value ~= '' then
            list[idx].index = idx
            table.insert(next, list[idx])
          end
          ::continue::
        end
        return next
      end
      local entry_display = require 'telescope.pickers.entry_display'

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = filter_empty_string(harpoon:list().items),
            entry_maker = function(entry)
              local line = string.sub('   ' .. entry.index, -3) .. '  ' .. entry.value
              return {
                value = entry,
                ordinal = line,
                display = line,
                lnum = entry.row,
                col = entry.col,
                filename = entry.value,
              }
            end,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    keymap.set('n', '<leader>hl', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[h]arpoon marks [l]ist' })
    keymap.set('n', '<leader>hy', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[h]arpoon marks [m]anage' })
    keymap.set('n', '<leader>hh', function()
      harpoon:list():add()
    end, { desc = 'Mark file with [h]arpoon' })
    keymap.set('n', '<leader>hd', function()
      local open_file = vim.fn.expand '%:t'
      local list = harpoon:list()
      local _, index = list:get_by_value(open_file)
      if index > 0 then
        while index < list:length() do
          local next = list:get(index + 1)
          ---@diagnostic disable-next-line: param-type-mismatch
          list:replace_at(index, next)
          index = index + 1
        end
        list:remove_at(index)
      end
    end, { desc = '[h]arpoon mark - [d]elete' })
    keymap.set('n', '<leader>hp', function()
      harpoon:list():next()
    end, { desc = '[h]arpoon mark - [p]revious' })
    keymap.set('n', '<leader>hn', function()
      harpoon:list():prev()
    end, { desc = '[h]arpoon mark - [n]ext' })
    keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = '[h]arpoon mark - [c]lear all' })
  end,
}
