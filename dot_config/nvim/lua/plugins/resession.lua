local utils = require("helpers.utils")
return {
  'stevearc/resession.nvim',
  opts = {
    dir = utils.RESESSION_ROOT_PATH .. '/' .. vim.fn.getcwd():gsub("^" .. vim.pesc(vim.fn.expand("~")) .. "/?", ""),
  },
}
