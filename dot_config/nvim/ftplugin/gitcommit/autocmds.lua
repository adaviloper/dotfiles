local group = vim.api.nvim_create_augroup('adaviloper/gitcommit_ticket_prefix', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  callback = function(args)
    local branch = require('helpers.git_utils').get_git_branch()
    local ticket = branch:match('(%u+%-%d+)')
    if not ticket then
      return
    end

    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ''
    if first_line ~= '' then
      return -- amend / already has a message, don't touch it
    end

    vim.api.nvim_buf_set_lines(args.buf, 0, 1, false, { ticket .. ': ' })
    vim.api.nvim_win_set_cursor(0, { 1, #ticket + 1 })
  end,
})
