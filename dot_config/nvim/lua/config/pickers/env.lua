local M = {}

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
    local variable = string.match(line, "([A-Z0-9_]*)=.*")
    if variable ~= nil then
      --
      local key = string.match(line, "([A-Z0-9_]*)=.*")
      local value = string.match(line, "[A-Z0-9_]*=(.*)")
      table.insert(lines, {
        text = variable,
        key = key,
        value = value,
      })
    end
  end
  return lines
end

function M.read_env()
  --
  local cwd = vim.fn.getcwd(0)
  local env_file = cwd .. "/.env"
  local lines = lines_from(env_file)

  local Snacks = require("snacks")
  Snacks.picker.pick({
    source = "project_env",
    items = lines,
    format = "text",
    layout = {
      preview = false,
      layout = {
        height = 0.3,
        max_width = 60,
      },
    },
    confirm = function(picker, item)
      ---
      picker:close()
      vim.cmd("find +/" .. item.text .. "= .env")
    end,
    actions = {
      copy_key_name = function (picker, item)
        picker:close()
        vim.fn.setreg('+', item.key)
        vim.schedule(function ()
          vim.notify('Copied [' .. item.key .. '] to [+] register.')
        end)
      end,
      copy_env_value = function (picker, item)
        picker:close()
        vim.fn.setreg('+', item.value)
        vim.schedule(function ()
          vim.notify('Copied [' .. item.key .. ']\'s value to [+] register.')
        end)
      end
    },
    win = {
      input = {
        keys = {
          ["<C-k>"] = { "copy_key_name", mode = { 'i', 'n' }},
          ["<C-v>"] = { "copy_env_value", mode = { 'i', 'n' }},
        }
      },
    },
  })
end

return M
