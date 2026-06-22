return
  {
  },
  {
    s(
      'dml',
      fmt(
        [[echo "{}"]],
        {
          f(
            function ()
              local pos = vim.api.nvim_win_get_cursor(0)

              return vim.fn.expand('%:t') .. ':' .. pos[1]
            end
          ),
        }
      )
    )
  }


