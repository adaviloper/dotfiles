-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

require('config.highlights')
require('config.autocmds')
require('config.commands.run_shell_current_line')

-- Set up custom filetypes
vim.filetype.add({
  extension = {
    -- log = "json",
    neon = "yaml",
    zsh = "sh",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
    ["~/%.config/bin/.*"] = "sh",
    ["~/%.dotfiles/config/bin/.*"] = "sh",
    ["laravel.*log"] = "json",
    ["*"] = "text",
  },
})

-- Function overwrites
vim.ui.open = function (path)
  vim.validate({
    path = { path, 'string' },
  })
  
  local is_uri = path:match('%w+:')
  local is_half_url = path:match('%.com$') or path:match('%.com%.')
  local is_repo = vim.tbl_contains({'lua', 'tmux'}, vim.bo.filetype) and path:match('%w/%w') and vim.fn.count(path, '/') == 1
  local is_dir = path:match('/%w')

  if not is_uri then
    if is_half_url then
      path = ('https://%s'):format(path)
    elseif is_repo then
      path = ('https://github.com/%s'):format(path)
    elseif not is_dir then
      path = ('https://google.com/search?q=%s'):format(path)
    else
      path = vim.fs.normalize(path)
    end
  end

  local cmd --- @type string[]
  if vim.fn.has('mac') == 1 then
    cmd = { 'open', path }
  elseif vim.fn.has('win32') == 1 then
    if vim.fn.executable('rundll32') == 1 then
      cmd = { 'rundll32', 'url.dll,FileProtocolHandler', path }
    else
      return nil, 'vim.ui.open:rundll32 not found'
    end
  elseif vim.fn.has('wslview') == 1 then
    cmd = { 'wslview', path }
  elseif vim.fn.has('explorer.exe') == 1 then
    cmd = { 'explorer.exe', path }
  elseif vim.fn.has('xdg-open') == 1 then
    cmd = { 'xdg-open', path }
  end

  vim.notify(path)
  return vim.system(cmd, { text = true, detach = true }), nil
end
