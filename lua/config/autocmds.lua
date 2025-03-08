-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local api = vim.api
local opt = vim.opt

local function augroup(name)
  return api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

api.nvim_create_autocmd("FileType", {
  group = augroup("LanguageSpecific"),
  pattern = "ruby",
  command = "setlocal indentkeys-=.",
})

api.nvim_create_autocmd({ "TabNew", "TabEnter", "TabLeave", "TabClosed" }, {
  group = augroup("Tabline"),
  callback = function()
    opt.showtabline = 1
  end,
})
