return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'InsertEnter',
  keys = {
    {
      '<leader>a',
      mode = { 'n', 'x' },
      '<cmd>Copilot! attach<CR>',
      desc = '[a]ssist',
    },
  },
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = '<F4>',
      },
    },
    panel = { enabled = false },
    filetypes = {
      ['*'] = true,
    },
  },
}
