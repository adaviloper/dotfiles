return {
  'rcarriga/nvim-notify',
  opts = function(_, options)
    options.level = 2
    options.render = "compact"
    return options
  end
}
