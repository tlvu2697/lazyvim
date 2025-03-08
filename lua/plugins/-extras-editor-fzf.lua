return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        -- formatter = "path.filename_first",
        formatter = "path.dirname_first",
      },
      actions = {
        files = {
          true,
          ["ctrl-l"] = require("trouble.sources.fzf").actions.open,
          ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
        },
      },
      winopts = {
        fullscreen = true,
        preview = {
          scrollchars = { "┃", "" },
          horizontal = "right:50%",
          wrap = true,
        },
      },
    },
    keys = {
      { "<c-]>", "<cmd>FzfLua tags_grep_cword<cr>", desc = "Tags (cwd)" },
      { "<c-]>", "<cmd>FzfLua tags_grep_visual<cr>", mode = "v", desc = "Tags (visual)" },
      {
        "<leader>ff",
        function()
          LazyVim.pick("files", { cwd = vim.fn.expand("%:h") })()
        end,
        desc = "Find Files (Relatively)",
      },
      { "<leader>fF", false },
    },
  },
}
