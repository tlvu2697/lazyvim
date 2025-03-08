local g = vim.g
local map = LazyVim.safe_keymap_set

return {
  {
    "ludovicchabant/vim-gutentags",
    lazy = false,
    init = function()
      g.gutentags_ctags_exclude = {
        "*.min.js",
        "*.min.css",
        "build",
        "vendor",
        ".git",
        "node_modules",
        "*.vim/bundle/*",
        ".bundle",
        "spec",
      }
      g.gutentags_modules = { "ctags" }
    end,
  },
  {
    "AndrewRadev/splitjoin.vim",
    event = "LazyFile",
    init = function()
      g.splitjoin_split_mapping = "gK"
      g.splitjoin_join_mapping = "gJ"
    end,
  },
  {
    "vim-test/vim-test",
    event = "LazyFile",
    init = function()
      g["test#strategy"] = "vimux"
      g["test#preserve_screen"] = 1
      g["test#ruby#bundle_exec"] = 1
      g["test#ruby#use_binstubs"] = 0
    end,
    keys = {
      { "<leader>tb", mode = { "n" }, "<cmd>TestFile<cr>", desc = "Test File" },
      { "<leader>tt", mode = { "n" }, "<cmd>TestNearest<cr>", desc = "Test Nearest" },
    },
  },
}
