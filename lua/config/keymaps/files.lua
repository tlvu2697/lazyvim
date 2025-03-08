local map = LazyVim.safe_keymap_set

map("n", "<leader><space>", "<cmd>w<cr><esc>", { desc = "Save File" })
map(
  "n",
  "<leader>fyd",
  ':let @+=fnamemodify(expand("%:h"), ":~:.") | echo @+<CR>',
  { silent = true, remap = false, desc = "Directory Path" }
)
map(
  "n",
  "<leader>fyy",
  ':let @+=fnamemodify(expand("%"), ":~:.") | echo @+<CR>',
  { silent = true, remap = false, desc = "Relative File Path" }
)
map(
  "n",
  "<leader>fyl",
  ':let @+=fnamemodify(expand("%"), ":~:.").":".line(".") | echo @+<CR>',
  { silent = true, remap = false, desc = "Relative File Path with Line number" }
)
map(
  "n",
  "<leader>fyY",
  ':let @+=expand("%:p") | echo @+<CR>',
  { silent = true, remap = false, desc = "Full File Path" }
)
map(
  "n",
  "<leader>fyn",
  ':let @+=expand("%:t:r") | echo @+<CR>',
  { silent = true, remap = false, desc = "File Name without extension" }
)
map(
  "n",
  "<leader>fyN",
  ':let @+=expand("%:t") | echo @+<CR>',
  { silent = true, remap = false, desc = "File Name with extension" }
)
