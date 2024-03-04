-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- delete single character without copying into register
keymap.set('n', 'x', '"_x')

-- increment/decrement numbers
keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- move lines in visual mode
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

keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- replace current word
keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'File: [R]ename [w]ord' })

-- apparently not the same
keymap.set('i', '<C-c>', '<Esc>')

-- stop acidental presses
keymap.set('n', 'Q', '<nop>')

------------------
-- Plugin Keymaps
------------------
keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' }) -- open local file history
keymap.set('n', '<leader>g', vim.cmd.Git, { desc = '[G]it status' }) -- open git status
