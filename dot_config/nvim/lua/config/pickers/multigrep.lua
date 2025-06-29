local snacks = require("snacks")
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local config = require('telescope.config').values

local M = {}

M.live_multigrep = function (opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function (prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }

      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end
      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, '*.' .. pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten({
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'}
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  -- pickers.new(opts, {
  --   debounce = 100,
  --   prompt_title = 'Live Multigrep',
  --   finder = finder,
  --   previewer = config.grep_previewer(opts),
  --   sorter = require('telescope.sorters').empty()
  -- }):find()

  snacks.picker.pick(nil, {
    title = 'Multi',
    layout = {
      preview = true,
      layout = {
        backdrop = false,
        width = 0.5,
        -- min_width = 80,
        height = 0.4,
        min_height = 3,
        box = "vertical",
        border = "rounded",
        title = "{title}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
    finder = finder,
  })
end

return M
