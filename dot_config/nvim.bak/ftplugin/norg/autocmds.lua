local norg_group = vim.api.nvim_create_augroup('adaviloper/norg-todo-list', { clear = true })

local function sync_action_items_to_dooing(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local in_action_items = false
  local action_items_level = nil
  local tasks = {}

  for i, line in ipairs(lines) do
    local stars = line:match("^(%*+)%s")
    if stars then
      local level = #stars
      if line:match("^%*+%s+Action Items") then
        in_action_items = true
        action_items_level = level
      elseif in_action_items and level <= action_items_level then
        in_action_items = false
      end
    end

    if in_action_items then
      local task = line:match("^%s*%- %( %)%s+(.+)$")
      if task then
        table.insert(tasks, { idx = i, text = task, indent = line:match("^(%s*)") })
      end
    end
  end

  if #tasks == 0 then return end

  local config = require("dooing.config")
  local save_path = config.options.save_path
  local todos = {}

  local rf = io.open(save_path, "r")
  if rf then
    local content = rf:read("*all")
    rf:close()
    if content and content ~= "" then
      local ok, decoded = pcall(vim.fn.json_decode, content)
      if ok and type(decoded) == "table" then todos = decoded end
    end
  end

  for _, item in ipairs(tasks) do
    local unique_id = os.time() .. "_" .. math.random(1000, 9999)
    table.insert(todos, {
      id = unique_id,
      text = item.text,
      done = false,
      in_progress = false,
      category = item.text:match("#(%w+)") or "",
      created_at = os.time(),
      priorities = {},
      notes = "",
      depth = 0,
    })
    vim.api.nvim_buf_set_lines(buf, item.idx - 1, item.idx, false, {
      item.indent .. "- [→ Dooing] " .. item.text,
    })
  end

  local wf = io.open(save_path, "w")
  if wf then
    wf:write(vim.fn.json_encode(todos))
    wf:close()
  end

  -- Write the buffer so replacements are persisted
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("noautocmd write")
  end)

  vim.notify(string.format("%d action item(s) synced to Dooing", #tasks), vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd({ "BufDelete", "VimLeavePre" }, {
  group = norg_group,
  pattern = "*.norg",
  callback = function(args)
    sync_action_items_to_dooing(args.buf)
  end,
})

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
