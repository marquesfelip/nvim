-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Move line like VS Code
keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)

keymap.set('n', 'J', 'mzJ`z')

-- Jump and centralize
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
keymap.set('x', '<leader>p', '"_dP')

-- copy to system clipboard
keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank do System Clipboard' })
keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank do System Clipboard' })
keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank do System Clipboard' })

keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

keymap.set('n', '<leader>rs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Rename' })
keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', opts)

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Jumplist
keymap.set('n', '<C-m>', '<C-i>', opts)

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<S-tab>', ':tabprev<Return>', opts)

-- Split Window
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

-- Move window
keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', opts)
keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', opts)
keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', opts)
keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', opts)

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Go snippets
keymap.set('n', '<leader>cge', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>', { desc = 'Check and Return [E]rror' })
keymap.set('n', '<leader>cga', 'oassert.NoError(err, "")<Esc>F";a', { desc = 'Insert [A]ssert Error' })
keymap.set('n', '<leader>cgf', 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj', { desc = 'Check and Log [F]atal Error' })
keymap.set('n', '<leader>cgl', 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i', { desc = 'Check and [L]og Error' })
