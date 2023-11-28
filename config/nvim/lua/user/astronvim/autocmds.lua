-- vim.api.nvim_create_augroup("VerticallyCenterWhileInserting", { clear = true })
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   desc = "Keep the current line vertically centered while in insert mode", -- nice description
--   pattern = "*", -- the pattern si the name of our User autocommand events
--   group = "VerticallyCenterWhileInserting", -- add the autocmd to the newly created augroup
--   callback = function()
--     vim.cmd("norm zz")
--   end,
-- })
vim.api.nvim_create_autocmd("BufNewFile", {
  desc = 'Add opening PHP tags for a new file', -- nice description
  pattern = '*.php', -- the pattern si the name of our User autocommand events
  command = '0r ~/.config/nvim/lua/user/skeleton/skeleton.php'
})
