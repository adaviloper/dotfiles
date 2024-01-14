local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local function file_exists(file)
  if vim.fn.filereadable(file) ~= 1 then return nil end
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- our picker function: colors
local env_values = function(opts)
  local cwd = vim.fn.getcwd(0)
  local env_file = cwd .. '/.env'
  local lines = lines_from(env_file)

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Environment Variables",
    finder = finders.new_table({
      results = lines,
      entry_maker = function(entry)
        local variable, val = string.match(entry, '(.*)=(.*)')
        return {
          value = entry,
          display = variable .. ' => ' .. val,
          ordinal = variable
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection['ordinalAPP_URL'] }, "", false, true)
        vim.cmd('find +/' .. selection.ordinal .. ' .env')
        -- vim.fs.find(vim.fn.getcwd(0, 0), {})
      end)
      return true
    end,
  }):find()
end

-- to execute the function
env_values(require('telescope.themes').get_dropdown({}))
