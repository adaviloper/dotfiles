-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

require('config.autocmds')
require('config.commands.shell_current_line')

-- Set up custom filetypes
vim.filetype.add({
  extension = {
    -- log = "json",
    neon = "yaml",
    tmux = "sh",
    zsh = "sh",
  },
  filename = {
    [".env"] = "sh",
    [".env.default"] = "sh",
    ["Foofile"] = "fooscript",
    ["composer.lock"] = "json",
    ["dot_zshrc.tmpl"] = "zsh",
    ["phpstan.neon.dist"] = "phpstan",
    ["tmux.conf.tmpl"] = "tmux",
  },
  pattern = {
    [".*/dot_config/bin/.*"] = "sh",
    [".*.lua.tmpl"] = "lua",
    [".*.sh.tmpl"] = "sh",
    [".*.toml.tmpl"] = "toml",
    [".*.yaml.tmpl"] = "yaml",
    [".*.yml.tmpl"] = "yaml",
    [".*.zsh.tmpl"] = "sh",
    ["laravel.*log"] = "json",
  },
})

-- Function overwrites
vim.ui.open = (function(overridden)
  return function(path)
    vim.validate({ path = { path, "string" } })

    local current_ft = (vim.bo and vim.bo.filetype) or ""
    local is_uri = path:match("^%a[%w+.-]*:") ~= nil
    local is_dir = (vim.fn and vim.fn.isdirectory(path) == 1) or false
    local is_repo_like = (current_ft == "lua" or current_ft == "tmux")
      and path:match("^[%w_.-]+/[%w_.-]+$") ~= nil
    local looks_like_domain = path:match("^[%w%-%.]+%.[A-Za-z][A-Za-z]+") ~= nil

    if not is_uri then
      if looks_like_domain then
        if not path:match("^https?://") then
          path = ("https://%s"):format(path)
        end
      elseif is_repo_like then
        path = ("https://github.com/%s"):format(path)
      elseif not is_dir then
        local q = path:gsub("%s+", "+")
        path = ("https://google.com/search?q=%s"):format(q)
      end
    end

    if overridden then
      overridden(path)
    else
      vim.notify("No UI opener available for: " .. path, vim.log.levels.WARN)
    end
  end
end)(vim.ui.open)
