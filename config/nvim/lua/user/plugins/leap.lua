return {
  "ggandor/leap.nvim",
  lazy = false,
  config = function(_, opts)
    require('leap').add_default_mappings()
    return opts
  end
}
