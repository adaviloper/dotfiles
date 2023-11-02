return {
  'rcarriga/nvim-notify',
  opts = function (_, options)
    options.level = 3
    options.render = "compact"
    return options
  end
}
