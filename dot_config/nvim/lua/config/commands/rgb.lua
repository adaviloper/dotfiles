vim.api.nvim_create_user_command(
  'RGB2Dec',
  function(opts)
    local range = opts.range > 0
    local s, e, end_col
    if range then
      s = vim.fn.getpos("'<")
      e = vim.fn.getpos("'>")
      end_col = math.min(e[3], #vim.fn.getline(e[2]))
    end

    local rgb = opts.fargs[1]
    if not rgb then
      if not range then
        vim.notify('RGB2Dec: need an argument or a visual selection', vim.log.levels.ERROR)
        return
      end
      rgb = table.concat(
        vim.api.nvim_buf_get_text(0, s[2] - 1, s[3] - 1, e[2] - 1, end_col, {}),
        ''
      )
    end
    rgb = rgb:gsub('^#', '')

    local c = {}
    for i in rgb:gmatch('..') do
      table.insert(c, tonumber(i, 16))
    end
    local str = table.concat(c, ' ')

    if range then
      vim.api.nvim_buf_set_text(0, s[2] - 1, s[3] - 1, e[2] - 1, end_col, { str })
    else
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2], pos[1] - 1, pos[2], { str })
    end
  end,
  {
    nargs = '?',
    range = true,
  }
)
