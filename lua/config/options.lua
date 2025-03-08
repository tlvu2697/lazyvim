-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
local g = vim.g
local opt = vim.opt
local wo = vim.wo

vim.env.NODE_OPTIONS = "--max-old-space-size=8192"

g.lazyvim_picker = "fzf"
g.root_spec = { "cwd" }

g.autoformat = false
g.snacks_animate = false
g.trouble_lualine = false
g.matchparen_timeout = 2
g.matchparen_insert_timeout = 2

opt.cursorline = false
opt.laststatus = 2
opt.wrap = true
opt.ignorecase = true                         -- Ignore case
opt.foldenable = true                         -- Enable code folding
opt.undofile = false
opt.spell = false
opt.conceallevel = 0

wo.wrap = true
