return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  keys = {
    {
      '<leader>ss',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = '[S]earch [S]creen',
    },
    -- {
    --   'S',
    --   mode = { 'n', 'x', 'o' },
    --   function()
    --     require('flash').treesitter()
    --   end,
    --   desc = 'Flash Treesitter',
    -- },
  },
}
