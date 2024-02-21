local utils = require('helpers.utils')
local ls = require('luasnip')

local function setFileTag(tagName)
  return {
    function()
      require('grapple').tag({ key = tagName })
    end,
    desc = 'Tag as [' .. tagName .. ']'
  }
end

local function jumpToFileTag(tagName)
  return {
    function()
      require('grapple').select({ key = tagName })
      -- vim.cmd('norm zt')
    end,
    desc = 'Jump to the [' .. tagName .. '] tag'
  }
end

local function getFileTypes()
  return {
    'Css',
    'JavaScript',
    'JSON',
    'Markdown',
    'PHP',
    'Text',
  }
end

local function getFileExtension(ft)
  local ext_map = {
    ['Css'] = 'css',
    ['JavaScript'] = 'js',
    ['JSON'] = 'json',
    ['Markdown'] = 'md',
    ['PHP'] = 'php',
    ['Text'] = 'txt',
  }
  return ext_map[ft]
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<leader><leader>s"] = { "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<cr>"},
          ["<leader>un"] = { function() vim.o.relativenumber = vim.o.relativenumber ~= true end, desc = 'Toggle relativenumber'},
          ["<leader>W"] = { "<cmd>wa<cr>", desc = "Save all" },
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astroui.buffer").close(bufnr) end
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
              require("astrocore.buffer").close(0)
              if require("astrocore").is_available("alpha-nvim") and not bufs[2] then
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

          ["<leader>mt"] = setFileTag("test"),
          ["<leader>'t"] = jumpToFileTag("test"),
          ["<leader>ms"] = setFileTag("subject"),
          ["<leader>'s"] = jumpToFileTag("subject"),
          ["<leader>mw"] = setFileTag("primary"),
          ["<leader>'w"] = jumpToFileTag("primary"),
          ["<leader>me"] = setFileTag("secondary"),
          ["<leader>'e"] = jumpToFileTag("secondary"),
          ["<leader>mr"] = setFileTag("tertiary"),
          ["<leader>'r"] = jumpToFileTag("tertiary"),
          ["<leader>ml"] = setFileTag("log"),
          ["<leader>'l"] = jumpToFileTag("log"),

          -- ISwap
          ["Q"] = { "<cmd>ISwapWith<cr>" },
          [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
          ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" }, -- better search
          n = { utils.better_search "nzz", desc = "Next search" },
          N = { utils.better_search "Nzz", desc = "Previous search" },         -- quick save

          -- NeoTeset
          ["<F4>"] = { name = "Testing", },
          ["<F4>n"] = { function() require('php-dev-tools').test_nearest_method() end, desc = "Run nearest test" },
          ["<F4>f"] = { function() require('php-dev-tools').test_current_file() end, desc = "Test the entire file" },

          -- Telescope
          ["<leader>fo"] = { function() require("telescope.builtin").oldfiles({ cwd_only = true }) end, desc = "Find history" },
          ['<leader>fd'] = { '<cmd>Telescope dir live_grep<CR>', desc = 'Find words in directory' },
          ['<leader>fe'] = { '<cmd>Telescope telescope-env env_values theme=dropdown<CR>', desc = 'Find env values' },
          ["<leader>f_"] = { '<cmd>ScratchOpen<cr>', desc = "Open a Scratch file" },

          -- Notify
          ["<leader>uD"] = { function() require('notify').dismiss() end, desc = 'Dismiss all displayed notifications'},

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
          ['<C-n>'] = {
            function()
              -- local ft = vim.fn.input('Filetype: ', '', 'file')
              vim.ui.select(
                getFileTypes(),
                {prompt = 'Filetype:'},
                function (choice)
                  local ft = getFileExtension(choice)
                  require('scratch').scratchByType(ft)
                end
              )
            end,
            desc = 'Open new scratch file'
          },

          -- TreeSJ
          ["gS"] = {
            function() require('treesj').split() end,
            desc = 'TreeSJ split',
          },
          ["gJ"] = { function() require('treesj').join() end, desc = 'TreeSJ join'},

          -- Git
          ["<leader>gB"] = { '<cmd>G blame<cr>', desc = 'Commit annotations'},
        },
        i = {
          [":"] = {
            function()
              -- The cursor location does not give us the correct node in this case, so we
              -- need to get the node to the left of the cursor
              local cursor = vim.api.nvim_win_get_cursor(0)
              local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
              local language = require('nvim-treesitter.parsers').get_parser():lang()

              if not vim.tbl_contains({'php', 'javascript'}, language) then
                return ':'
              end
              local node = vim.treesitter.get_node { pos = left_of_cursor_range }
              local html_nodes_active_in = {
                'shorthand_property_identifier',
                'object',
              }
              if not node then
                return ':'
              end

              if vim.tbl_contains(html_nodes_active_in, node:type()) then
                -- The cursor is not on an attribute node
                return ': ,<left>'
              end

              return ':'
            end,
            desc = 'Auto-add quotes for HTML attributes',
            expr = true,
          },
          ["="] = {
            function()
              -- The cursor location does not give us the correct node in this case, so we
              -- need to get the node to the left of the cursor
              local cursor = vim.api.nvim_win_get_cursor(0)
              local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

              local language = require('nvim-treesitter.parsers').get_parser():lang()
              if not vim.tbl_contains({'php', 'javascript'}, language) then
                return '='
              end

              local node = vim.treesitter.get_node { pos = left_of_cursor_range }
              if not node then
                return '='
              end
              local html_nodes_active_in = {
                'attribute_name',
                'directive_argument',
                'directive_name',
                'property_identifier',
              }

              if vim.tbl_contains(html_nodes_active_in, node:type()) then
                -- The cursor is not on an attribute node
                return '=""<left>'
              end

              local php_nodes_active_in = {
                'array_creation_expression',
                'array_element_initializer',
              }
              if vim.tbl_contains(php_nodes_active_in, node:type()) then
                -- The cursor is not on an attribute node
                return '=> ,<left>'
              end

              return '='
            end,
            desc = 'Auto-add quotes for HTML attributes',
            expr = true,
          },
          -- Luasnip
          ['<C-k>'] = {
            function ()
              if ls.jumpable(-1) then
                ls.jump(-1)
              end
            end,
            desc = 'Jump to next snippet',
            silent = true,
          },
          ['<C-j>'] = {
            function ()
              if ls.jumpable(1) then
                ls.jump(1)
              end
            end,
            desc = 'Jump to previous snippet',
            silent = true,
          },
          ['<C-h>'] = {
            function ()
              if ls.choice_active() then
                ls.change_choice(-1)
              end
            end,
            desc = 'Cycle through active choices'
          },
          ['<C-l>'] = {
            function ()
              if ls.choice_active() then
                ls.change_choice(1)
              end
            end,
            desc = 'Cycle through active choices'
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
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Hover symbol details",
          },
          ["gd"] = {
            function ()
              -- require('php-dev-tools').go_to_definition()
              require('telescope.builtin').lsp_definitions()
            end,
            desc = "Go to definition",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function()
              vim.lsp.buf.declaration()
            end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
          ["<leader>lo"] = {
            function ()
              vim.lsp.buf.code_action({
                filter = function (ca)
                  if ca.command ~= nil then
                    return ca.command.title == 'Remove unused imports'
                  end
                  return false
                end,
                apply = true
              })
            end,
            desc = 'Optimize imports',
          },
        },
      },
    },
  },
}
