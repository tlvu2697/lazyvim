return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      modes = {
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range", autojump = true },
          search = { incremental = false },
          label = { before = false, after = false, style = "inline" },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    },
    keys = {
      { "s", false },
      { "S", false },
      { "r", false },
      { "R", false },
      { "<c-s>", false },
      -- Simulate nvim-treesitter incremental selection
      {
        "<c-space>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev",
            },
          })
        end,
        desc = "Treesitter Incremental Selection",
      },
    },
  },
}
