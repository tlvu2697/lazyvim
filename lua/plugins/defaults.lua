return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "none" }
        end,
      },
    },
    opts = {
      ensure_installed = {
        "lua",
        "ruby",
        "typescript",
        "tsx",
        "javascript",
      },
      auto_install = true,
      endwise = { enable = true },
      matchup = { enable = true },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          { "<leader><tab>", desc = "Next Tab" },
          { "<leader>A", group = "+projectionist" },
          { "<leader>fy", group = "+yank" },
          { "<leader>t", group = "+test" },
          { "ga", group = "+text-case" },
        },
      },
    },
    keys = {
      { "<c-w><space>", false },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
