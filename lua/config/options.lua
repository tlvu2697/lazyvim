-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
local g = vim.g
local opt = vim.opt
local wo = vim.wo

g.lazyvim_picker = "fzf"
g.root_spec = { "cwd" }

g.autoformat = false
g.snacks_animate = false
g.trouble_lualine = false

opt.cursorline = false
opt.laststatus = 2
opt.wrap = true

opt.foldenable = true                         -- Enable code folding
opt.foldlevelstart = 10                       -- Start with folds at level 5
opt.undofile = false

wo.wrap = true
