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
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                  entriesLimit = 3000,
                },
              }
            },
            typescript = {
              format = {
                enable = false,
              },
              tsserver = {
                maxTsServerMemory = 32768,
              },
              preferences = {
                importModuleSpecifier = "project-relative",
              },
            },
            javascript = {
              format = {
                enable = false,
              },
              preferences = {
                importModuleSpecifier = "project-relative",
              },
            },
          },
        },
      },
    },
  },
}
