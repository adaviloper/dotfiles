local utils = require "user.utils"

return {
  -- first key is the mode
  n = {
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
    ["<leader>f'"] = { '<cmd>MarksQFListAll<CR>', desc = "List all marks"},
    ["<leader>fS"] = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = "Search for symbol in workspace"},
    -- Harpoon
    ["<leader>m"] = { name = "󱡅 Harpoon" },
    ["<leader>ma"] = { function () require("harpoon.mark").add_file() end, desc = "Add file to Harpoon list" },
    ["<leader>mm"] = { function () require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon quick menu" },
    ["<leader>ml"] = { function () require("harpoon.ui").nav_next() end, desc = "Navigate to previous harpoon mark" },
    ["<leader>mh"] = { function () require("harpoon.ui").nav_prev() end, desc = "Navigate to next harpoon mark" },
    -- ISwap
    ["Q"] = { "<cmd>ISwapWith<cr>" },
    [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
    ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" },    -- better search
    n = { utils.better_search "nzz", desc = "Next search" },
    N = { utils.better_search "Nzz", desc = "Previous search" }, -- quick save
    -- NeoTeset
    ["<F4>"] = { name = "NeoTest", },
    ["<F4>n"] = { function() require("neotest").run.run() end, desc = "Run nearest test" },
    ["<F4>f"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test the entire file" },
    ["<F4>d"] = { function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    ["<F4>e"] = { function() require("neotest").run.stop() end, desc = "Stop nearest test" },
    ["<F4>a"] = { function() require("neotest").run.attach() end, desc = "Attach to the nearest test" },
    ["<F4>o"] = { function() require("nejotest").output_panel.toggle() end, desc = "View the output" },
    ["<F4>s"] = { function() require("neotest").summary.toggle() end, desc = "View the output" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition"},
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to references"},
        -- Telescope
    ['<leader>T'] = { name = 'Telescope' },
    ['<leader>fd'] = { '<cmd>Telescope dir live_grep<CR>', desc = 'Find words in directory' },
    ['<A-j>'] = { ':move .+1<CR>=='},
    ['<A-k>'] = { ':move .-2<CR>=='},
    ['<A-Down>'] = { '<cmd>resize -4<CR>' },
    ['<A-Up>'] = { '<cmd>resize +4<CR>' },
    ['<A-Left>'] = { '<cmd>vertical resize -4<CR>' },
    ['<A-Right>'] = { '<cmd>vertical resize +4<CR>' },
    X = { "x~", desc = "Delete current character and capitalize the next"},
  },
  i = {
    ['<A-j>'] = { '<Esc>:move .+1<CR>==gi'},
    ['<A-k>'] = { '<Esc>:move .-2<CR>==gi'},
  },
  v = {
    ["<"] = { "<gv", desc = "Unindent without losing selection"},
    [">"] = { ">gv", desc = "Indent without losing selection"},
    ["p"] = { '"_dP', desc = "Paste yanked text without losing the original contents"},
    ["y"] = { "myy`y", desc = "Yank in visual mode without losing cursor position"},
    J = { ":move '>+1<CR>gv=gv"},
    K = { ":move '<-2<CR>gv=gv"},
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
