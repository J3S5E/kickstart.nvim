-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- delete single character without copying into register
keymap.set('n', 'x', '"_x')

-- move lines
keymap.set('n', '<C-j>', ':m +1<CR>')
keymap.set('n', '<C-k>', ':m -2<CR>')
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- traversing with cursor in center
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- paste without overriding clipboard
keymap.set('x', '<leader>p', '"_dP')

-- yank into sys clipboard
keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to sys clipboard' })
keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank to sys clipboard' })

keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete (without copying to register)' })

-- replace current word
keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'File: [R]ename [W]ord' })

-- apparently not the same
keymap.set('i', '<C-c>', '<Esc>')

-- stop acidental presses
keymap.set('n', 'Q', '<nop>')

-- buffer nav
keymap.set('n', '<leader>bp', ':bp<cr>', { desc = '[B]uffer: [P]revious' })
keymap.set('n', '<leader>bn', ':bn<cr>', { desc = '[B]uffer: [N]ext' })
keymap.set('n', '<leader>bd', ':bd<cr>', { desc = '[B]uffer: [D]elete' })
keymap.set('n', '<leader>bl', ':ls<cr>', { desc = '[B]uffer: [L]ist' })

------------------
-- Plugin Keymaps
------------------
keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' }) -- open local file history
keymap.set('n', '<leader>g', vim.cmd.Git, { desc = '[G]it status' }) -- open git status
