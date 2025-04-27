-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    'ThePrimeagen/harpoon',
  },
  lazy = false,
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = '', -- this can only be used in the git_status source
          renamed = '󰁕', -- this can only be used in the git_status source
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '󰓎',
          staged = '󰄲',
          conflict = '',
        },
      },
      icon = {
        folder_empty = '',
      },
      modified = {
        symbol = '',
        highlight = 'NeoTreeModified',
      },
      indent = {
        indent_size = 1,
      },
    },
    commands = {
      show_only_buffers = function()
        vim.api.nvim_input ':Neotree focus buffers left<cr>'
      end,
      show_only_git = function()
        vim.api.nvim_input ':Neotree focus git_status left<cr>'
      end,
    },
    filesystem = {
      components = {
        harpoon_index = function(config, node, _)
          local harpoon = require 'harpoon'
          local path = node:get_id()
          local cwd = vim.fn.getcwd()
          local list = harpoon:list()
          local file_name = path:gsub(cwd, ''):sub(2)
          local success, index = list:get_by_value(file_name)
          if success and index and index > 0 then
            return {
              text = string.format('󱡅 %d', index),
              highlight = config.highlight or 'NeoTreeDirectoryIcon',
            }
          else
            return {}
          end
        end,
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true,
      renderers = {
        file = {
          { 'indent' },
          { 'icon' },
          {
            'container',
            content = {
              {
                'name',
                zindex = 10,
              },
              {
                'symlink_target',
                zindex = 10,
                highlight = 'NeoTreeSymbolicLinkTarget',
              },
              { 'clipboard', zindex = 10 },
              { 'bufnr', zindex = 10 },
              { 'harpoon_index', zindex = 20, align = 'right' },
              { 'modified', zindex = 20, align = 'right' },
              { 'diagnostics', zindex = 20, align = 'right' },
              { 'git_status', zindex = 10, align = 'right' },
              { 'file_size', zindex = 10, align = 'right' },
              { 'type', zindex = 10, align = 'right' },
              { 'last_modified', zindex = 10, align = 'right' },
              { 'created', zindex = 10, align = 'right' },
            },
          },
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['b'] = 'show_only_buffers',
          ['g'] = 'show_only_git',
        },
      },
    },
  },
}
