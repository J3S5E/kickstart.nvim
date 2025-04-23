return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    vim.keymap.set('n', '<leader>tc', '<cmd>ColorizerToggle<cr>', { desc = 'Toggle [C]olours' })
  end,
}
