return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    config = function ()
      require('copilot').setup({
        filetypes = {
          javascript = true,
          typescript = true,
          php = true,
          sh = true,
          ["*"] = false, -- Keeping a whitelist of allowed filetypes where Copilot is allowed
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end
  },
}
