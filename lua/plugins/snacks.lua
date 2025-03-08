_G.MUtils.snacks = {
  open_commit = function(picker, item)
    picker:close()

    local function system(cmd, err)
      local proc = vim.fn.system(cmd)
      if vim.v.shell_error ~= 0 then
        Snacks.notify.error({ err, proc }, { title = "Git Browse" })
        error("__ignore__")
      end
      return vim.split(vim.trim(proc), "\n")
    end

    for _, line in ipairs(system({ "git", "-C", vim.fn.getcwd(), "remote", "-v" }, "Failed to get git remotes")) do
      local name, remote = line:match("(%S+)%s+(%S+)%s+%(fetch%)")
      if name and remote then
        local repo = Snacks.gitbrowse.get_repo(remote)
        if repo then
          local url = Snacks.gitbrowse.get_url(repo, { commit = item.commit })

          require("lazy.util").open(url, { system = true })
        end
      end
    end
  end,
}

return {
  "folke/snacks.nvim",
  opts = {
    words = { enabled = false },
    styles = {
      lazygit = {
        width = 0.95,
        height = 0.95,
      },
    },
    notifier = {
      top_down = false,
    },
    explorer = { enabled = false },
    picker = {
      formatters = {
        file = {
          filename_first = false, -- display filename before the file path
          truncate = 100, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
        },
      },
      layout = {
        preset = "default",
        fullscreen = true,
      },
      sources = {
        explorer = {
          follow_file = false,
          win = {
            list = {
              keys = {
                ["<c-t>"] = "tab",
                ["<Esc>"] = function() end,
                ["<Up>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<Down>"] = { "preview_scroll_down", mode = { "i", "n" } },
              },
            },
            input = {
              keys = {
                ["<Up>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<Down>"] = { "preview_scroll_down", mode = { "i", "n" } },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    -- explorer
    { "<leader><space>", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>e", false },
    { "<leader>E", false },

    -- find
    { "<c-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    {
      "<leader>ff",
      function()
        LazyVim.pick("files", { cwd = vim.fn.expand("%:h") })()
      end,
      desc = "Find Files (Relatively)",
    },
    { "<leader>fF", false },
  },
}
