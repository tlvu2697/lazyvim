vim.lsp.set_log_level("off")

-- Custom code action handler with sorting
local function sorted_code_action(options)
  options = options or {}

  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_range_params()
  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
  }

  -- Custom sort function for code actions
  local function sort_code_actions(actions)
    -- Priority order (lower number = higher priority)
    local priority_patterns = {
      { pattern = "Add import", priority = 1 },
      { pattern = "Add all missing imports", priority = 2 },
      { pattern = "Move to", priority = 3 },
      { pattern = "Extract", priority = 4 },
      { pattern = "Refactor", priority = 5 },
      { pattern = "%[vtsls%]", priority = 10 }, -- Prioritize vtsls actions (match [vtsls] in title)
      { pattern = "%[typescript", priority = 10 }, -- Prioritize TypeScript actions
      { pattern = "%[eslint%]", priority = 100 }, -- Deprioritize ESLint actions
      { pattern = "Disable.*for this line", priority = 200 },
      { pattern = "Disable.*for the entire file", priority = 201 },
      { pattern = "Show documentation", priority = 202 },
    }

    local function get_priority(action)
      local title = action.title or ""

      for _, rule in ipairs(priority_patterns) do
        if title:find(rule.pattern) then
          return rule.priority
        end
      end

      return 50 -- Default priority for unmatched actions
    end

    table.sort(actions, function(a, b)
      local priority_a = get_priority(a)
      local priority_b = get_priority(b)

      if priority_a == priority_b then
        -- If same priority, sort alphabetically by title
        return (a.title or "") < (b.title or "")
      end

      return priority_a < priority_b
    end)

    return actions
  end

  vim.lsp.buf_request_all(bufnr, "textDocument/codeAction", params, function(results)
    if not results or vim.tbl_isempty(results) then
      vim.notify("No code actions available", vim.log.levels.INFO)
      return
    end

    -- Collect all actions from all clients and add client name to title
    local all_actions = {}
    for client_id, result in pairs(results) do
      if result.result then
        local client = vim.lsp.get_client_by_id(client_id)
        local client_name = client and client.name or "unknown"

        for _, action in ipairs(result.result) do
          action.client_id = client_id
          -- Add client name postfix if not already present
          if not action.title:match("%[.+%]$") then
            action.title = "[" .. client_name .. "] " .. action.title
          end
          table.insert(all_actions, action)
        end
      end
    end

    if #all_actions == 0 then
      vim.notify("No code actions available", vim.log.levels.INFO)
      return
    end

    -- Sort the actions
    all_actions = sort_code_actions(all_actions)

    -- Present sorted actions to user
    vim.ui.select(all_actions, {
      prompt = "Code actions:",
      format_item = function(action)
        return action.title
      end,
    }, function(selected_action)
      if not selected_action then
        return
      end

      -- Apply the selected action
      if selected_action.edit then
        vim.lsp.util.apply_workspace_edit(selected_action.edit, "utf-8")
      end

      if selected_action.command then
        local client = vim.lsp.get_client_by_id(selected_action.client_id)
        if client then
          client:request("workspace/executeCommand", selected_action.command, function(err)
            if err then
              vim.notify("Error executing command: " .. vim.inspect(err), vim.log.levels.ERROR)
            end
          end, bufnr)
        end
      end
    end)
  end)
end

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
    opts = {
      servers = {
        ["*"] = {
          keys = {
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
            -- Override code action with sorted version
            {
              "<leader>ca",
              sorted_code_action,
              desc = "Code Action",
              mode = { "n", "x" },
              has = "codeAction",
            },
          },
        },
      },
    },
  },
}
