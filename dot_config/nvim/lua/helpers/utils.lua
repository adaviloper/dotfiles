local M = {}

M.RESESSION_ROOT_PATH = 'dirsession'

local function rel_cwd()
  return vim.fn.getcwd():gsub("^" .. vim.pesc(vim.fn.expand("~")) .. "/?", "")
end

function M.get_session_name()
  local branch = vim.fn.system("git branch --show-current"):gsub("/", "_")
  if vim.v.shell_error == 0 then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "#" .. vim.trim(branch --[[@as string]])
  else
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end
end

function M.get_session_dir()
  return vim.fn.stdpath('data') .. '/' .. M.RESESSION_ROOT_PATH .. '/' .. rel_cwd()
end

function M.session_path()
  return M.get_session_dir() .. '/' .. M.get_session_name() .. '.json'
end

function M.prune_sessions(max)
  local dir = M.get_session_dir()

  local handle = vim.uv.fs_opendir(dir, nil, 64)
  if not handle then return end

  local entries = {}
  while true do
    local items = vim.uv.fs_readdir(handle)
    if not items then break end
    for _, item in ipairs(items) do
      if item.type == 'file' and item.name:match('%.json$') then
        local path = dir .. '/' .. item.name
        local stat = vim.uv.fs_stat(path)
        if stat then
          table.insert(entries, { path = path, mtime = stat.mtime.sec })
        end
      end
    end
  end
  vim.uv.fs_closedir(handle)

  if #entries <= max then return end

  table.sort(entries, function(a, b) return a.mtime < b.mtime end)
  for i = 1, #entries - max do
    vim.uv.fs_unlink(entries[i].path)
  end
end

return M
