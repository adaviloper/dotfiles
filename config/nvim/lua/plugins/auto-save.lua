return {
  'okuuva/auto-save.nvim',
  event = { 'User AstroFile', 'InsertEnter' },
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    write_all_buffers = true, -- write all buffers when the current one meets `condition`
    debounce_delay = 3000, -- delay after which a pending save is executed
  },
}
