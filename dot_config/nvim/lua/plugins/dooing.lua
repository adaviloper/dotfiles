return {
  "atiladefreitas/dooing",
  enabled = false,
  config = function()
    require("dooing").setup({
      calendar = {
        start_day = "monday",
      },

      keymaps = {
        open_project_todo = "<LocalLeader>tt"
      },

      pretty_print_json = true,

      priorities = {
        {
          name = "important",
          weight = 4,
        },
        {
          name = "urgent",
          weight = 2,
        },
        {
          name = "low",
          weight = -1,
        },
      },

      quick_keys = false,

      window = {
        width = 100,
      },
    })
  end,
}
