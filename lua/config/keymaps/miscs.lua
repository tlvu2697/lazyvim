require 'helper'

local map = LazyVim.safe_keymap_set

map("n", "K", "i<CR><ESC>", { silent = true, remap = false, desc = "Add breakline at cursor" })
map("", "$", "g_", { silent = true, remap = false, desc = "Goto endline without linebreak" })
map("", "Q", "<Nop>", { silent = true, remap = false, desc = "Disable Ex mode" })
map("x", "@", ':<C-u><cmd>lua _G.MUtils.visualMacroExecute()<CR>')
