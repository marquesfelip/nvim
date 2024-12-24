-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Move line like VS Code
keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)

-- Jump and centralize
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', '<C-d>', '<C-d>zz')

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
