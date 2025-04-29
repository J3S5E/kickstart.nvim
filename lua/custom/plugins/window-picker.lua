return {

  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup()
  end,
  keys = {
    {
      '<C-w>e',
      mode = { 'n', 'x', 'o' },
      function()
        local picked_window_id = require('window-picker').pick_window {
          hint = 'floating-big-letter',
        }
        if picked_window_id ~= nil then
          vim.fn.win_gotoid(picked_window_id)
        end
      end,
      desc = 'Pick a Window',
    },
  },
}
