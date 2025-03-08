vim.g.lazyvim_eslint_auto_format = false

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = false,
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 3000,
              },
            },
            typescript = {
              format = {
                enable = false,
              },
              tsserver = {
                maxTsServerMemory = 32768,
                importModuleSpecifier = "project-relative",
              },
            },
            javascript = {
              format = {
                enable = false,
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
}
