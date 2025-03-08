return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = {
          -- Disable mason for this server, install it manually: bundle add rubocop
          mason = false,
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
          filetypes = { "ruby" },
          root_markers = { "Gemfile", ".git" },
        },
        ruby_lsp = {
          -- Disable mason for this server, install it manually: gem install ruby-lsp
          mason = false,
          init_options = {
            addonSettings = {
              ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
              },
            },
            enabledFeatures = {
              formatting = false,
            },
          },
          root_markers = { "Gemfile", ".git" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { "bundle_rubocop" },
      },
      formatters = {
        bundle_rubocop = {
          meta = {
            url = "https://github.com/rubocop/rubocop",
            description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
          },
          command = "bundle",
          args = {
            "exec",
            "rubocop",
            "--server",
            "--autocorrect",
            "--format",
            "--stderr",
            "--stdin",
            "$FILENAME",
          },
          exit_codes = { 0, 1 },
        },
      },
    },
  },
}
