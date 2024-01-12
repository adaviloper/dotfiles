local utils = require "user.utils"
local ls = require('luasnip')

return {
  -- first key is the mode
  n = {
    ["<leader><leader>s"] = { "<cmd>source ~/.config/nvim/lua/user/plugins/luasnip.lua"},
    ["<leader>W"] = { "<cmd>wa<cr>", desc = "Save all" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = true })
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available("alpha-nvim") and not bufs[2] then
          require("alpha").start(true)
        end
      end,
      desc = "Close buffer",
    },
    -- Bookmarks
    ["<leader>fS"] = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = "Search for symbol in workspace" },
    -- Grapple
    ["<leader>m"] = { name = "󰓾 Handle file tags" },
    ["<leader>'"] = { name = "󰓾 Jump to file tags" },
    ["<leader>mf"] = { function() require('grapple').popup_tags() end, desc = "List all tags" },
    ["<leader>mF"] = { function() require('grapple').popup_scopes() end, desc = "List all scopes" },
    ["<leader>ma"] = { function() require("grapple").tag() end, desc = "Add Grapple tag to file" },
    ["<leader>md"] = { function() require("grapple").untag() end, desc = "Remove file from Grapple tag list" },

    ["<leader>mt"] = { function() require("grapple").tag({ key = "test" }) end, desc = "Tag as [test]" },
    ["<leader>'t"] = { function() require("grapple").select({ key = "test" }) end, desc = "Jump to the [test] tag" },
    ["<leader>ms"] = { function() require("grapple").tag({ key = "subject" }) end, desc = "Tag as [subject]" },
    ["<leader>'s"] = { function() require("grapple").select({ key = "subject" }) end, desc = "Jump to the [subject] tag" },
    ["<leader>mw"] = { function() require("grapple").tag({ key = "primary" }) end, desc = "Tag as [primary]" },
    ["<leader>'w"] = { function() require("grapple").select({ key = "primary" }) end, desc = "Jump to [primary] tag" },
    ["<leader>me"] = { function() require("grapple").tag({ key = "secondary" }) end, desc = "Tag as [secondary]" },
    ["<leader>'e"] = { function() require("grapple").select({ key = "secondary" }) end, desc = "Jump to [secondary] tag" },
    ["<leader>mr"] = { function() require("grapple").tag({ key = "tertiary" }) end, desc = "Tag as [tertiary]" },
    ["<leader>'r"] = { function() require("grapple").select({ key = "tertiary" }) end, desc = "Jump to [tertiary] tag" },

    -- ISwap
    ["Q"] = { "<cmd>ISwapWith<cr>" },
    [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
    ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" }, -- better search
    n = { utils.better_search "nzz", desc = "Next search" },
    N = { utils.better_search "Nzz", desc = "Previous search" },         -- quick save
    -- NeoTeset
    ["<F4>"] = { name = "NeoTest", },
    ["<F4>n"] = { function() require("neotest").run.run() end, desc = "Run nearest test" },
    ["<F4>f"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test the entire file" },
    ["<F4>d"] = { function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    ["<F4>e"] = { function() require("neotest").run.stop() end, desc = "Stop nearest test" },
    ["<F4>a"] = { function() require("neotest").run.attach() end, desc = "Attach to the nearest test" },
    ["<F4>o"] = { function() require("nejotest").output_panel.toggle() end, desc = "View the output" },
    ["<F4>s"] = { function() require("neotest").summary.toggle() end, desc = "View the output" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
    -- Telescope
    ["<leader>fo"] = { function() require("telescope.builtin").oldfiles({ cwd_only = true }) end, desc = "Find history" },
    ['<leader>fd'] = { '<cmd>Telescope dir live_grep<CR>', desc = 'Find words in directory' },
    ['<leader>fe'] = { '<cmd>Telescope env<CR>', desc = 'Find env values' },
    X = { "x~", desc = "Delete current character and capitalize the next" },
    ["<leader>/"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>j",
      desc = "Toggle comment line",
    },
    ["<C-i>"] = { "<C-i>zz", desc = "Jump forward and center" },
    ["<C-o>"] = { "<C-o>zz", desc = "Jump backward and center" },
    -- Copying
    ['<localleader>y'] = { name = '󰆏 Copy...' },
    ['<localleader>yp'] = { function() vim.fn.setreg('+', vim.fn.expand('%:p:.')) end, desc = 'Copy file path' },
    ['<localleader>yd'] = { function() vim.fn.setreg('+', vim.fn.expand('%:h')) end, desc = 'Copy directory path' },
    ['<localleader>yf'] = { function() vim.fn.setreg('+', vim.fn.expand('%:t:r')) end, desc = 'Copy file name' },
    -- Scratch
    ['<C-n>'] = { function()
      -- local ft = vim.fn.input('Filetype: ', '', 'file')
      vim.ui.select(
        {'PHP', 'JSON', 'JS', 'Vue Template'},
        {prompt = 'Filetype:'},
        function (choice)
          local ft = string.lower(choice)
          if choice == 'Vue Template' then
            ft = 'vue'
          end
          require('scratch').scratchByType(ft)
        end
      )
    end,
      desc = 'Open new scratch file'}
  },
  i = {
    -- Luasnip
    ['<C-k>'] = {
      function ()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
      desc = 'Jump to next snippet',
      silent = true,
    },
    ['<C-j>'] = {
      function ()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      desc = 'Jump to previous snippet',
      silent = true,
    },
  },
  v = {
    ["<"] = { "<gv", desc = "Unindent without losing selection" },
    [">"] = { ">gv", desc = "Indent without losing selection" },
    ["p"] = { '"_dP', desc = "Paste yanked text without losing the original contents" },
    ["y"] = { "myy`y", desc = "Yank in visual mode without losing cursor position" },
    ["<leader>/"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>j",
      desc = "Toggle comment for selection",
    }
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
