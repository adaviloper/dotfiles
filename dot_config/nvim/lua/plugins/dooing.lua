return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup({
      pretty_print_json = true,

      quick_keys = false,

      window = {
        width = 100,
      },
    })
  end,
}
