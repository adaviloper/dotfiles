return {
  'cbochs/grapple.nvim',
  config = function()
    require('grapple').define_scope({
		  name = "cwd_branch",
		  desc = "Current working directory and git branch",
		  fallback = "cwd",
		  cache = {
			  event = { "BufEnter", "FocusGained" },
			  debounce = 1000, -- ms
		  },
		  resolver = function()
			  local git_files = vim.fs.find(".git", { upward = true, stop = vim.loop.os_homedir() })
			  if #git_files == 0 then
				  return
			  end

			  local root = vim.loop.cwd()

			  local result = vim.fn.system({ "git", "symbolic-ref", "--short", "HEAD" })
			  local branch = vim.trim(string.gsub(result, "\n", ""))

			  local id = string.format("%s:%s", root, branch)
			  local path = root

			  return id, path
		  end,
    })
    require('grapple').setup({
      scope = 'cwd_branch',
      popup_options = {
        width = 150,
      },
    })
  end,
}
