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

    function dump(a)
      if type(a) == 'table' then
        local b = '{ '
        for c, d in pairs(a) do
          if type(c) ~= 'number' then
            c = '"' .. c .. '"'
          end
          b = b .. '[' .. c .. '] = ' .. dump(d) .. ','
        end
        return b .. '} '
      else
        return tostring(a)
      end
    end

    local function updateKeys(list_items)
      local items = list_items
      for idx = 1, 9, 1 do
        -- ask for input to pause
        if items[idx] == nil then
          -- TO-DO have a check if keymap exists then delete
          keymap.set('n', '<leader>hg' .. idx, function()
            print('no harpoon mark set for ' .. idx)
          end, { desc = '' })
          keymap.del('n', '<leader>hg' .. idx)
        else
          keymap.set('n', '<leader>hg' .. idx, function()
            harpoon:list():select(idx)
          end, { desc = items[idx].value })
        end
      end
    end

    local function updateMarks(cx)
      require('neo-tree.sources.manager').refresh()
      if cx == nil then
        vim.input 'no harpoon marks set'
        return
      end
      local list = cx.list
      local items = cx.items
      if list ~= nil then
        items = list.items
      end
      if items ~= nil then
        updateKeys(items)
      end
    end

    harpoon:extend {
      ADD = updateMarks,
      LIST_CREATED = updateMarks,
      REMOVE = updateMarks,
      REORDER = updateMarks,
      NAVIGATE = updateMarks,
    }

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
    keymap.set('n', '<leader>hm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[h]arpoon marks [m]anage' })
    keymap.set('n', '<leader>hh', function()
      harpoon:list():add()
    end, { desc = '[h]arpoon mark - mark with [h]arpoon' })
    keymap.set('n', '<leader>hd', function()
      local open_file = vim.fn.expand '%:t'
      local list = harpoon:list()
      local item = list:get_by_value(open_file)
      harpoon:list().remove(list, item)
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
