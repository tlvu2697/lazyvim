return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    keys[#keys + 1] = { "K", false }
    keys[#keys + 1] = {
      "gd",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
      end,
      desc = "[G]oto [D]efinition [V]split",
      has = "definition",
    }
    keys[#keys + 1] = {
      "gr",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.references()
      end,
      desc = "References",
      nowait = true,
    }
    keys[#keys + 1] = {
      "gI",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.implementation()
      end,
      desc = "Goto Implementation",
    }
    keys[#keys + 1] = {
      "gy",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.type_definition()
      end,
      desc = "Goto T[y]pe Definition",
    }
    keys[#keys + 1] = {
      "gD",
      function()
        vim.cmd("vsplit")
        vim.lsp.buf.declaration()
      end,
      desc = "Goto Declaration",
    }
  end,
}
