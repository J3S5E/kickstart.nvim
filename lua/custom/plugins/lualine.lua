return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'

    -- configure lualine with theme
    lualine.setup {
      options = {
        theme = 'codedark',
      },
    }
  end,
}
