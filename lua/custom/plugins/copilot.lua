return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'InsertEnter',
  keys = {
    {
      '<leader>ac',
      mode = { 'n', 'x' },
      '<cmd>Copilot! attach<CR>',
      desc = '[a]ssist with [c]opilot',
    },
  },
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = '<Tab>',
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      ['*'] = false,
    },
  },
}
