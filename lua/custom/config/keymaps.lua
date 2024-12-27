-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set('n', 'q', '<nop>')
keymap.set('n', 'Q', '<nop>')
keymap.set('n', 'J', 'mzJ`z')

-- Move line like VS Code
keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)

-- Jump and centralize
keymap.set('n', '<C-u>', '<C-u>zz', opts)
keymap.set('n', '<C-d>', '<C-d>zz', opts)
keymap.set('n', 'n', 'nzzzv', opts)
keymap.set('n', 'N', 'Nzzzv', opts)

-- greatest remap ever
keymap.set('x', '<leader>p', '"_dP', { desc = '[P]ast and preserve the copy' })

-- Copy to system clipboard
keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank do System Clipboard' })
keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank do System Clipboard' })
keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank do System Clipboard' })

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

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

-- Harpoon
keymap.set('n', '<leader>a', function()
  require('harpoon'):list():add()
end, { desc = 'Harpoon [A]dd File' })

keymap.set('n', '<leader>hq', function()
  local harpoon = require 'harpoon'
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon [Q]uick Menu' })

keymap.set('n', '<A-1>', function()
  require('harpoon'):list():select(1)
end, { desc = 'Harpoon to File 1' })

keymap.set('n', '<A-2>', function()
  require('harpoon'):list():select(2)
end, { desc = 'Harpoon to File 2' })

keymap.set('n', '<A-3>', function()
  require('harpoon'):list():select(3)
end, { desc = 'Harpoon to File 3' })

keymap.set('n', '<A-4>', function()
  require('harpoon'):list():select(4)
end, { desc = 'Harpoon to File 4' })

keymap.set('n', '<A-5>', function()
  require('harpoon'):list():select(5)
end, { desc = 'Harpoon to File 5' })

keymap.set('n', '<A-6>', function()
  require('harpoon'):list():select(6)
end, { desc = 'Harpoon to File 6' })
-- /Harpoon

-- Quicklist
keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz', { desc = 'Jump to Previous on Quickfix list' })
keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz', { desc = 'Jump to Next on Quickfix list' })
-- keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz', { desc = 'Jump to Previous on List' })
-- keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz', { desc = 'Jump to Next on List' })

-- Go snippets
keymap.set('n', '<leader>cge', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>', { desc = 'Check and Return [E]rror' })
keymap.set('n', '<leader>cga', 'oassert.NoError(err, "")<Esc>F";a', { desc = 'Insert [A]ssert Error' })
keymap.set('n', '<leader>cgf', 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj', { desc = 'Check and Log [F]atal Error' })
keymap.set('n', '<leader>cgl', 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i', { desc = 'Check and [L]og Error' })
