vim.lsp.set_log_level("off")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 5000 },
      inlay_hints = { enabled = false },
      document_highlight = {
        enabled = false,
      },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()

      vim.list_extend(Keys, {
        { "K", false },
        {
          "gd",
          function()
            Snacks.picker.lsp_definitions({
              auto_confirm = false,
            })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
        {
          "gr",
          function()
            Snacks.picker.lsp_references({
              auto_confirm = false,
            })
          end,
          nowait = true,
          desc = "References",
        },
        {
          "gI",
          function()
            Snacks.picker.lsp_implementations({
              auto_confirm = false,
            })
          end,
          desc = "Goto Implementation",
        },
        {
          "gy",
          function()
            Snacks.picker.lsp_type_definitions({
              auto_confirm = false,
            })
          end,
          desc = "Goto T[y]pe Definition",
        },
      })

      -- keys[#keys + 1] = {
      --   "gd",
      --   function()
      --     vim.cmd("vsplit")
      --     vim.lsp.buf.definition()
      --   end,
      --   desc = "[G]oto [D]efinition [V]split",
      --   has = "definition",
      -- }
    end,
  },
}
