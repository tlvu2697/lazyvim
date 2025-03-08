require("helper")

local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local map = LazyVim.safe_keymap_set

return {
  {
    "ntpeters/vim-better-whitespace",
    event = "LazyFile",
    init = function()
      g.strip_whitespace_on_save = 1
      g.strip_whitespace_confirm = 0
      g.better_whitespace_enabled = 1
      g.strip_max_file_size = 0
      g.better_whitespace_filetypes_blacklist = {
        "diff",
        "fugitive",
        "git",
        "gitcommit",
        "help",
        "nofile",
        "qf",
        "snacks_dashboard",
        "unite",
      }
    end,
  },
  {
    "junegunn/vim-easy-align",
    event = "LazyFile",
    config = function()
      cmd([[
        xmap <leader>ea <Plug>(EasyAlign)
      ]])
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "LazyFile",
    main = "hop",
    opts = {
      quit_key = "<Tab>",
      create_hl_autocmd = true,
    },
    config = function(_, opts)
      require("hop").setup(opts)

      map("n", "<Tab>", "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
    end,
  },
  {
    "tpope/vim-projectionist",
    event = "LazyFile",
    config = function()
      local rake = {
        ["lib/*.rake"] = {
          alternate = "spec/lib/{}_rake_spec.rb",
          type = "source",
        },
        ["spec/*_rake_spec.rb"] = {
          alternate = "{}.rake",
          type = "test",
        },
      }

      local rails = {
        ["app/*.rb"] = {
          alternate = "spec/{}_spec.rb",
          type = "source",
        },
        ["app/controllers/*_controller.rb"] = {
          alternate = {
            "spec/requests/{}_spec.rb",
            "spec/controllers/{}_controller_spec.rb",
          },
          type = "source",
        },
        ["spec/requests/*_spec.rb"] = {
          command = "request",
          alternate = "app/controllers/{}_controller.rb",
          type = "test",
        },
        ["lib/*.rb"] = {
          alternate = "spec/lib/{}_spec.rb",
          type = "source",
        },
        ["spec/*_spec.rb"] = {
          alternate = {
            "app/{}.rb",
            "{}.rb",
          },
          type = "test",
        },
      }

      local javascript = {
        ["*.js"] = {
          alternate = {
            "{dirname}/__tests__/{basename}.spec.js",
            "{dirname}/__tests__/integration.spec.js",
            "{dirname}/__test__/{basename}.spec.js",
            "{dirname}/__test__/integration.spec.js",
          },
          type = "source",
        },
        ["*/integration.spec.js"] = {
          type = "test",
          alternate = {
            "{dirname}/index.js",
            "{dirname}/index.ts",
            "{dirname}/index.tsx",
          },
        },
        ["*.spec.js"] = {
          alternate = {
            "{dirname}/../{basename}.js",
            "{dirname}/../{basename}.ts",
            "{dirname}/../{basename}.tsx",
          },
          type = "test",
        },
      }

      local typescript = {
        ["*.ts"] = {
          alternate = {
            "{dirname}/__tests__/{basename}.spec.ts",
            "{dirname}/__test__/{basename}.spec.js",
          },
          type = "source",
        },
        ["*.tsx"] = {
          alternate = {
            "{dirname}/__tests__/{basename}.spec.tsx",
            "{dirname}/__tests__/integration.spec.tsx",
            "{dirname}/__test__/{basename}.spec.tsx",
            "{dirname}/__test__/integration.spec.tsx",
          },
          type = "source",
        },
      }

      g.projectionist_heuristics = {
        ["*"] = _G.MUtils.tablesMerge(rake, rails, javascript, typescript),
      }

      map("n", "<leader>AA", ":w <bar> :e <bar> :A<CR>", { silent = true, desc = "Alternate" })
      map("n", "<leader>AS", ":w <bar> :e <bar> :AS<CR>", { silent = true, desc = "Split" })
      map("n", "<leader>AV", ":w <bar> :e <bar> :AV<CR>", { silent = true, desc = "VSplit" })
      map("n", "<leader>AT", ":w <bar> :e <bar> :AT<CR>", { silent = true, desc = "Tabsplit" })
    end,
  },
  {
    "gcmt/taboo.vim",
    lazy = false,
    init = function()
      opt.sessionoptions:append({ "tabpages", "globals" })
      g.taboo_tab_format = " [%N] %f /"
      g.taboo_renamed_tab_format = " [%N] %l /"
    end,
  },
  {
    "johmsalas/text-case.nvim",
    event = "LazyFile",
    opts = {
      default_keymappings_enabled = true,
      prefix = "ga",
    },
  },
  {
    "benmills/vimux",
    event = "LazyFile",
    init = function()
      g.VimuxOrientation = "h"
      g.VimuxHeight = "30%"
    end,
  },
  {
    "tpope/vim-surround",
    event = "LazyFile",
  },
}
