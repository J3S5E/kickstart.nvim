return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'All keymaps (which-key)',
    },
  },
  config = function()
    local wk = require 'which-key'
    wk.add {
      '<leader>bg',
      group = '[B]uffer: [G]oto',
      expand = function()
        return require('which-key.extras').expand.buf()
      end,
    }
  end,
}
