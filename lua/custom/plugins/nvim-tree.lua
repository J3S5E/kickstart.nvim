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
      },
      filters = {
        dotfiles = false,
        custom = { '^.git$' },
      },
      renderer = {
        icons = {
          glyphs = {
            git = {
              staged = '✓',
              deleted = '',
              renamed = 'R',
              unstaged = 'M',
              unmerged = 'UM',
              untracked = 'U',
              ignored = '_',
            },
          },
        },
      },
    }

    vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>')
  end,
}
