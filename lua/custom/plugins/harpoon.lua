return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>hl', '<cmd>Telescope harpoon marks<cr>', { desc = '[h]arpoon marks [l]ist' })
    keymap.set('n', '<leader>hh', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = 'Mark file with [h]arpoon' })
    keymap.set('n', '<leader>hp', "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = '[h]arpoon mark - [p]revious' })
    keymap.set('n', '<leader>hn', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = '[h]arpoon mark - [n]ext' })
  end,
}
