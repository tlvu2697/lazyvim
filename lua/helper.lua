_G.MUtils = {}

_G.MUtils.openInBrowser = function(url)
  local command = vim.loop.os_uname().sysname == "Darwin" and "open" or "xdg-open"
  require("plenary.job"):new({ command = command, args = { url } }):start()
end

_G.MUtils.visualMacroExecute = function()
  cmd('echo "@".getcmdline()')
  cmd([[execute ":'<,'>normal @".nr2char(getchar())]])
end

_G.MUtils.tableMerge = function(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        _G.MUtils.tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

_G.MUtils.tablesMerge = function(...)
  local mergedTables = {}

  for i, _table in ipairs({ ... }) do
    mergedTables = _G.MUtils.tableMerge(mergedTables, _table)
  end

  return mergedTables
end
