return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local nvimtree = require 'nvim-tree'

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup {
      view = {
        width = 40,
      },
      git = {
        ignore = false,
        enable = true,
        timeout = 1000,
      },
      filters = {
        dotfiles = false,
        custom = { '^.git$' },
      },
      renderer = {
        group_empty = true,
        icons = {
          glyphs = {
            git = {
              staged = '󰄲',
              deleted = '',
              renamed = '',
              unstaged = '󰓎',
              unmerged = '',
              untracked = '',
              ignored = '',
            },
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeToggle<CR>', { desc = '[F]ile explorer show/hide' })
  end,
}
