local group = vim.api.nvim_create_augroup('adaviloper/gitcommit_ticket_prefix', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function(args)
    local branch = require('helpers.git_utils').get_git_branch()
    local ticket = branch:match('(%u+%-%d+)')
    if not ticket then
      return
    end

    vim.schedule(function()
      vim.wo.colorcolumn = '60'

      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end

      local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ''
      if first_line ~= '' then
        return
      end

      local prefix = ticket .. ': '
      vim.api.nvim_buf_set_lines(args.buf, 0, 1, false, { prefix })
      vim.api.nvim_win_set_cursor(0, { 1, #prefix })
      vim.cmd.startinsert { bang = true }
    end)
  end,
})
