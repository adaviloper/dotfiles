local get_session_directory = function ()
  local cwd = vim.fn.getcwd()
  local home = vim.fn.expand("~")
  return cwd:gsub("^" .. vim.pesc(home) .. "/?", "")
end

return {
  'stevearc/resession.nvim',
  opts = {
    dir = 'dirsession/' .. get_session_directory(),
  },
}
