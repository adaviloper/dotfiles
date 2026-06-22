local utils = require("helpers.utils")
return {
  'stevearc/resession.nvim',
  opts = {
    dir = utils.RESESSION_ROOT_PATH .. '/' .. vim.fn.getcwd():gsub("^" .. vim.pesc(vim.fn.expand("~")) .. "/?", ""),
    buf_filter = function (bufnr)
      local buftype = vim.bo[bufnr].buftype
      if buftype == "help" then
        return true
      end
      if buftype ~= "" and buftype ~= "acwrite" then
        return false
      end
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == "" then
        return false
      end
      if name:match("^/tmp/.*%.md$") then
        return false
      end
      return vim.bo[bufnr].buflisted
    end
  },
}
