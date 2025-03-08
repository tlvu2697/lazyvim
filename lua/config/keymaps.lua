-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- buffers
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.set('x', '<leader>p', '"0p', { noremap = true, silent = true, desc = "Paste from register #0" })

-- tabs
map("n", "<c-t>", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- Explorer
vim.keymap.del("n", "<leader>fT")

-- Lazy
vim.keymap.del("n", "<leader>l")
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Move Lines
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
map("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Git
vim.keymap.del("n", "<leader>gl")
vim.keymap.del("n", "<leader>gL")
vim.keymap.del("n", "<leader>gG")
-- map("n", "<leader>gb", function()
--   Snacks.picker.git_log_line({ confirm = _G.MUtils.snacks.open_commit })
-- end, { desc = "Git Blame Line" })
map("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git Blame Line" })
map("n", "<leader>gf", function()
  Snacks.picker.git_log_file({ confirm = _G.MUtils.snacks.open_commit })
end, { desc = "Git Current File History" }
)

-- Clear search and stop snippet on escape
map("n", "<cr>", function()
  vim.cmd("noh")
end, { expr = true, desc = "Clear hlsearch" })

-- Search
map("v", "#", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { silent = true })
map("v", "*", "y?\\V<C-R>=escape(@\",'/\\')<CR><CR>", { silent = true })
map("n", "#", "/\\<<C-R>=expand('<cword>')<CR>\\><CR>", { silent = true })
map("n", "*", "?\\<<C-R>=expand('<cword>')<CR>\\><CR>", { silent = true })

require('config.keymaps.files')
require('config.keymaps.miscs')
