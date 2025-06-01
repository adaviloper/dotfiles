local norg_group = vim.api.nvim_create_augroup('adaviloper/norg-todo-list', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = norg_group,
  pattern = 'to-do.norg',
  callback = function(args)
    local cwd = vim.loop.cwd()
    local file_path = vim.api.nvim_buf_get_name(args.buf)
    local expected_path = cwd .. '/to-do.norg'

    if file_path == expected_path then
      local function group_and_sort_tasks()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

        local pending = {
          completed = {},
          past_due = {},
          this_week = {},
          within_month = {},
          beyond_month = {},
          needs_further_input = {},
          urgent = {},
          recurring = {},
          in_progress = {},
          on_hold = {},
          cancelled = {},
        }

        local now = os.time()
        local today_table = os.date("*t", now)
        today_table.hour = 0
        today_table.min = 0
        today_table.sec = 0
        local today = os.time(today_table)
        local week_later = today + 7 * 24 * 60 * 60
        local month_later = today + 30 * 24 * 60 * 60

        local function parse_date(line)
          local date_str = line:match("%d%d%d%d%-%d%d%-%d%d")
          if not date_str then return nil end
          local y, m, d = date_str:match("(%d+)%-(%d+)%-(%d+)")
          return os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d) })
        end

        for _, line in ipairs(lines) do
          local task_date = parse_date(line)
          if task_date then
            if line:match("^%s*%- %([xX]%)") then
              table.insert(pending.completed, { line = line, date = task_date })
            elseif line:match("^%s*%- %(%?%)") then
              table.insert(pending.needs_further_input, { line = line, date = task_date })
            elseif line:match("^%s*%- %(%-%)") then
              table.insert(pending.in_progress, { line = line, date = task_date })
            elseif line:match("^%s*%- %(=%)") then
              table.insert(pending.on_hold, { line = line, date = task_date })
            elseif line:match("^%s*%- %(_%)") then
              table.insert(pending.cancelled, { line = line, date = task_date })
            elseif line:match("^%s*%- %(%s?%)") then
              if task_date < today then
                table.insert(pending.past_due, { line = line, date = task_date })
              elseif task_date <= week_later then
                table.insert(pending.this_week, { line = line, date = task_date })
              elseif task_date <= month_later then
                table.insert(pending.within_month, { line = line, date = task_date })
              else
                table.insert(pending.beyond_month, { line = line, date = task_date })
              end
            end
          end
        end

        local function sort_by_date(a, b)
          return a.date < b.date
        end

        table.sort(pending.past_due, sort_by_date)
        table.sort(pending.this_week, sort_by_date)
        table.sort(pending.within_month, sort_by_date)
        table.sort(pending.beyond_month, sort_by_date)
        table.sort(pending.needs_further_input, sort_by_date)
        table.sort(pending.urgent, sort_by_date)
        table.sort(pending.in_progress, sort_by_date)
        table.sort(pending.on_hold, sort_by_date)
        table.sort(pending.cancelled, sort_by_date)

        local output = {
          "* To Do",
          ""
        }

        local function insert_group(title, group)
          if #group > 0 then
            table.insert(output, string.format("** %s (%d)", title, #group))
            for _, item in ipairs(group) do
              table.insert(output, item.line)
            end
            table.insert(output, "")
          end
        end

        insert_group("Urgent", pending.urgent)
        insert_group("Past Due", pending.past_due)
        insert_group("Needs Further Input", pending.needs_further_input)
        insert_group("On hold", pending.on_hold)
        insert_group("In Progress", pending.in_progress)
        insert_group("This Week", pending.this_week)
        insert_group("Within One Month", pending.within_month)
        insert_group("Beyond One Month", pending.beyond_month)

        insert_group("Completed", pending.completed)
        insert_group("Cancelled", pending.cancelled)

        vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
      end

      group_and_sort_tasks()
    end
  end,
})
