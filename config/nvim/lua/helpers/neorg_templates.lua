local neorg_utils = require("helpers.file_utils")
local file_utils = require("helpers.file_utils")
local str_utils = require("helpers.str_utils")

local M = {}

local createJournalEntry = function (path)
  local file = neorg_utils.file_exists(path)

  if file then
    vim.cmd('e ' .. path)
  else
    require("neorg.modules.core.dirman.module").public.create_file(path)
  end
end

M.createDailyEntry = function ()
  local year, month, week, day = os.date("%Y"), os.date("%m"), os.date("%V"), os.date("%d")
  local path = string.format("/journal/%s/%s/w%s/%s.norg", year, month, week, day)

  createJournalEntry(path)
end

M.createWeeklyEntry = function ()
  local year, month, week = os.date("%Y"), os.date("%m"), os.date("%V")
  local path = string.format("/journal/%s/%s/w%s/index.norg", year, month, week)

  createJournalEntry(path)
end

M.createPerson = function ()
  vim.ui.input({ prompt = 'Name:' }, function (name)
    if name ~= nil then
      local path = string.format("/people/%s.norg", str_utils.slug(name))

      createJournalEntry(path)
    end
  end)
end

M.createTicket = function ()
  vim.ui.input({ prompt = 'ID:' }, function (name)
    if name ~= nil then
      local path = string.format("/tickets/%s.norg", "APP-" .. name)

      createJournalEntry(path)
    end
  end)
end

M.createCompany = function ()
  vim.ui.input({ prompt = 'Company Name:' }, function (name)
    if name ~= nil then
      local path = string.format("/job-search/companies/%s.norg", str_utils.slug(name))

      createJournalEntry(path)
    end
  end)
end

M.createMeetingNote = function ()
  vim.ui.input({ prompt = 'Meeting title:' }, function (name)
    if name ~= nil then
      local year, month, day = os.date("%Y"), os.date("%m"), os.date("%d")
      local path = string.format("/meetings/%s/%s/%s/%s.norg", year, month, day, str_utils.slug(name))

      createJournalEntry(path)
    end
  end)
end

M.createOneOnOneNote = function ()
  local year, month, day = os.date("%Y"), os.date("%m"), os.date("%d")
  local path = string.format("/meetings/one-on-one/%s/%s/%s.norg", year, month, day)

  createJournalEntry(path)
end

M.createMeeting = function ()
  vim.ui.input({ prompt = 'Meeting Name:' }, function (name)
    if name ~= nil then
      local year, month, week = os.date("%Y"), os.date("%m"), os.date("%V")
      local path = string.format("/meeting/%s/%s/%s/%s.norg", year, month, week, str_utils.slug(os.date("%Y-%m-&d") .. name))

      createJournalEntry(path)
    end
  end)
end

M.template = function(pattern, template_name, additional_pattern)
  vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
    desc = "Autoload template for notes/journal",
    pattern = pattern,
    callback = function(args)
      local index = "index.norg"
      vim.schedule(function()
        if additional_pattern then
          if not args.file:match(additional_pattern) then
            vim.schedule(function ()
              vim.notify('pattern: ' .. additional_pattern)
              vim.notify('additional_pattern match not found against: ' .. args.file)
            end)
            return
          else
            vim.schedule(function ()
              vim.notify('pattern: ' .. additional_pattern)
              vim.notify('additional_pattern match found')
            end)
            vim.api.nvim_cmd({
              cmd = "Neorg",
              args = { "templates", "fload", template_name },
            }, {})

            return
          end
        end
        if vim.fn.fnamemodify(args.file, ":t") == index then
          return
        end
        if args.event == "BufNewFile"
          or (args.event == "BufNew"
          and file_utils.file_exists_and_is_empty(args.file)) then
          vim.api.nvim_cmd({
            cmd = "Neorg",
            args = { "templates", "fload", template_name },
          }, {})
        end
      end)
    end,
  })
end


M.weekdate = function(offset)
  local current_time = os.time()
  local year, month, day, wday =
    os.date("*t", current_time).year,
    os.date("*t", current_time).month,
    os.date("*t", current_time).day,
    os.date("*t", current_time).wday

  -- Adjust wday to make Monday the start of the week (Lua's wday starts on Sunday = 1)
  local day_offset = (wday == 1) and -6 or (offset - wday)
  local day_time = os.time { year = year, month = month, day = day + day_offset }
  local day_date = os.date("%d", day_time)

  return require("luasnip").text_node(day_date)
end

M.get_carryover_todos = function()
  local queryString = [[
        (heading2
          (heading2_prefix)
          title: (_)
          content: (generic_list
                     (unordered_list1
                       state: (detached_modifier_extension [
                         (todo_item_undone)
                         (todo_item_pending)
                       ])
                       content: (_)
                     ) @list
                   ))
    ]]

  local todos = {}

  local buf = { vim.api.nvim_buf_get_name(0):match "(%d%d%d%d)/(%d%d)/w(%d%d)/(%d%d)%.norg$" }

  if not buf[1] then return {} end

  local ws_path = require("neorg.modules.core.dirman.module").public.get_current_workspace()
  ws_path = ws_path[2]
  local year, month, week, day = os.date "%Y", os.date "%m", os.date "%V", os.date("%d", os.time() - 86400)
  local yesterday_path = ws_path .. string.format("/journal/%s/%s/w%s/%s.norg", year, month, week, day)
  local f = io.open(yesterday_path, "r")

  if not f then return {} end

  local content = f:read "*a"
  vim.schedule(function() vim.notify "file found" end)

  local parser = vim.treesitter.get_string_parser(content, "norg")
  local tree = parser:parse()[1]
  local root = tree:root()
  local lang = parser:lang()
  local query = vim.treesitter.query.parse(lang, queryString)

  local i = 0
  ---@diagnostic disable-next-line: missing-parameter
  for _, matches, _ in query:iter_matches(root, 0) do
    local m = vim.treesitter.get_node_text(matches[1], content)
    m = m:match "^.*[^\n]"
    for _, line in ipairs(vim.split(m, "\n")) do
      if i > 0 then
        line = "   " .. line -- just hard coding the correct indent for me. idk how to dynamically set this
      end
      table.insert(todos, line)
    end
    i = i + 1
  end

  return todos
end

return M
