vim.g.lazyvim_eslint_auto_format = false

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      document_highlight = {
        enabled = false,
      },
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        rubocop = {
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
          filetypes = { "ruby" },
          root_markers = { "Gemfile", ".git" },
        },
        ruby_lsp = {
          init_options = {
            addonSettings = {
              ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
              },
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              format = {
                enable = false,
              },
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
            javascript = {
              format = {
                enable = false,
              },
            },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            enableMoveToFileCodeAction = false,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 3000,
              },
            },
          },
        },
        eslint = {
          format = false,
          settings = {
            workingDirectories = { mode = "auto" },
          },
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 1000,
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        rubocop = {
          meta = {
            url = "https://github.com/rubocop/rubocop",
            description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
          },
          command = "bundle",
          args = {
            "exec",
            "rubocop",
            "--server",
            "-a",
            "-f",
            "quiet",
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
