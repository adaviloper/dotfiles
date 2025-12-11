return {
  'monaqa/dial.nvim',
  enabled = true,
  config = function()
    local augend = require('dial.augend')

    -- Define default augends that will be used as a base for all filetypes
    local default_augends = {
      augend.constant.alias.bool,
      augend.constant.alias.Bool,
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y-%m-%d"],
      augend.constant.alias.en_weekday_full,
      augend.semver.alias.semver,
      augend.constant.new({
        elements = { "get", "set" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "===", "!==" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "==", "!=" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "left", "right" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "up", "down" },
        word = false,
        cyclic = true,
      }),
    }

    require('dial.config').augends:register_group({
      default = default_augends,
    })

    -- Helper function to merge default augends with filetype-specific ones
    local function extend_with_default(filetype_augends)
      local merged = {}
      -- First add all default augends
      for _, a in ipairs(default_augends) do
        table.insert(merged, a)
      end
      -- Then add filetype-specific augends
      for _, a in ipairs(filetype_augends) do
        table.insert(merged, a)
      end
      return merged
    end

    require('dial.config').augends:on_filetype({
      typescript = extend_with_default({
        augend.constant.new({
          elements = { "const", "let", "var", },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "describe(", "describe.only(", "describe.skip(", },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "it(", "it.only(", "it.skip(", },
          word = false,
          cyclic = true,
        }),
      }),
      php = extend_with_default({
        augend.constant.new({
          elements = {"dd", "dump"},
        }),
      }),
      sh = extend_with_default({
        augend.constant.new({
          elements = {"production", "development", "local", "testing"},
        }),
      }),
    })
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
