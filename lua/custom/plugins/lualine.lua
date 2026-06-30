return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'J3S5E/breadcrumb.nvim',
  },
  config = function()
    local lualine = require 'lualine'

    local breadcrumb = function()
      local breadcrumb_status_ok, breadcrumb = pcall(require, 'breadcrumb')
      if not breadcrumb_status_ok then
        return
      end
      return breadcrumb.get_breadcrumb()
    end

    vim.opt.laststatus = 3

    -- configure lualine with theme
    lualine.setup {
      options = {
        theme = 'codedark',
        globalstatus = true,
        ignore_focus = { 'neo-tree', 'neo-tree filesystem' },
      },
      sections = {
        lualine_c = { breadcrumb },
      },
    }
  end,
}
