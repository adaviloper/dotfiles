vim.api.nvim_create_augroup("VerticallyCenterWhileInserting", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Keep the current line vertically centered while in insert mode", -- nice description
  -- pattern = "AstroBufsUpdated", -- the pattern si the name of our User autocommand events
  group = "VerticallyCenterWhileInserting", -- add the autocmd to the newly created augroup
  callback = function()
    vim.cmd("norm zz")
    vim.opt.scrolloff = 999
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Revert the scrolloff setting when exiting insert mode", -- nice description
  -- pattern = "AstroBufsUpdated", -- the pattern si the name of our User autocommand events
  group = "VerticallyCenterWhileInserting", -- add the autocmd to the newly created augroup
  callback = function()
    vim.opt.scrolloff = 8
  end,
})

vim.api.nvim_create_augroup("NewFileTemplates", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "Insert the opening PHP tags", -- nice description
  pattern = "*.php", -- the pattern si the name of our User autocommand events
  group = "NewFileTemplates", -- add the autocmd to the newly created augroup
  callback = function()
    vim.cmd("norm i <?php")
    vim.cmd("norm o")
    vim.cmd("norm o")
  end,
})
