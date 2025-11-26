local astro = require("astrocore")
local utils = require("helpers.utils")
local ls = require("luasnip")
local git_utils = require("helpers.git_utils")
local file_utils = require("helpers.file_utils")

local search_exclusions = {
  "node_modules*",
  "*.min.css",
  "*_min.css",
  "*.min.js",
  "*.min_*.js",
  "*_min.js",
  "*.map",
  "public/*",
  "dist/*",
  "*/dist/*",
  "build/*",
  "*/build/*",
}
local function setFileTag(tagName)
  return {
    function()
      local grapple = require("grapple")
      if not grapple.exists({ name = tagName }) then
        grapple.tag({ name = tagName })
      else
        local tag = grapple.find({ name = tagName })
        if tag == nil then return end

        vim.ui.select({
          "yes",
          "no",
        }, { prompt = "Overwrite [" .. tag.name .. "]" }, function(selection)
          if selection ~= nil and selection == "yes" then grapple.tag({ name = tagName }) end
        end)
      end
    end,
    desc = "Tag as [" .. tagName .. "]",
  }
end

local function jumpToFileTag(tagName)
  return {
    function() require("grapple").select({ name = tagName }) end,
    desc = "Jump to the [" .. tagName .. "] tag",
  }
end

return {
  -- first key is the mode
  n = {
    zg = {
      function ()
        local word = vim.fn.expand("<cword>")
        vim.cmd('spellgood ' .. word)  -- marks word as good directly

        local spellfile = vim.fn.expand(vim.o.spellfile)
        vim.fn.system({ "chezmoi", "add", spellfile })
        vim.fn.system({ "chezmoi", "add", spellfile .. '.spl' })
      end,
    },
    ["<A-e>"] = { "5<C-e>" },
    ["<A-y>"] = { "5<C-y>" },
    ["<A-j>"] = { "5j" },
    ["<A-k>"] = { "5k" },
    ["<C-Tab>"] = { "gt", desc = "Go to next tab" },
    ["<C-S-Tab>"] = { "gT", desc = "Go to previous tab" },

    ["<Leader>SS"] = {
      function()
        require("resession").save(utils.get_session_name(), {
          -- dir = "dirsession",
        })
      end,
      desc = "Save this dirsession",
    },
    -- update load dirsession mapping to get the correct session name
    ["<Leader>S."] = {
      function()
        require("resession").load(utils.get_session_name(), {
          -- dir = "dirsession",
        })
      end,
      desc = "Load current dirsession",
    },

    ["<Leader><Leader>e"] = { "<cmd>e<CR>", desc = "Reload the file" },
    ["<Leader><Leader>s"] = {
      function()
        local file_type = vim.bo.filetype
        local files = vim.split(vim.fn.glob("~/.config/nvim/snippets/" .. file_type .. "/*"), "\n")
        for _, file in pairs(files) do
          require("luasnip.loaders").reload_file(file)
        end
      end,
    },

    ["<Leader>uB"] = {
      -- toggle copilot
      function()
        if vim.g.copilot_enabled == nil then
          vim.g.copilot_enabled = true
        else
          vim.g.copilot_enabled = not vim.g.copilot_enabled
        end
      end,
    },
    ["<Leader>uG"] = {
      "<cmd>Gitsigns toggle_current_line_blame<CR>",
      desc = "Toggle current line blame",
    },
    ["<Leader>un"] = {
      function() vim.o.relativenumber = vim.o.relativenumber ~= true end,
      desc = "Toggle relativenumber",
    },

    ["<Leader>e"] = { "<Cmd>Neotree reveal toggle<CR>", desc = "NeoTree" },
    ["<Leader>eb"] = { "<Cmd>Neotree float buffers<CR>", desc = "Toggle Buffer Explorer" },
    ["<Leader>eg"] = { "<Cmd>Neotree float git_status<CR>", desc = "Toggle changed files" },

    ["<Leader>W"] = { "<cmd>wa<cr>", desc = "Save all" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<Leader>b"] = { name = "Buffers" },
    ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<Leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(function(bufnr) require("astroui.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<Leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = true })
        require("astrocore.buffer").close(0)
        if not bufs[2] then require("snacks").dashboard() end
      end,
      desc = "Close buffer",
    },
    ["<LocalLeader>D"] = { "<cmd>ClearDebugLogs<cr>", desc = "Clear debug logs" },
    -- Grapple
    ["<Leader>m"] = { name = "󰓾 Handle file tags" },
    ["<Leader>'"] = { name = "󰓾 Jump to file tags" },
    ["<Leader>mf"] = { function() require("grapple").open_tags() end, desc = "List all tags" },
    ["<Leader>mT"] = { "<cmd>Telescope grapple tags", desc = "List all tags" },
    ["<Leader>mF"] = { function() require("grapple").open_loaded() end, desc = "List all scopes" },
    ["<Leader>ma"] = { function() require("grapple").tag() end, desc = "Add Grapple tag to file" },
    ["<Leader>md"] = { function() require("grapple").untag() end, desc = "Remove file from Grapple tag list" },

    ["<Leader>mt"] = setFileTag("test"),
    ["<Leader>'t"] = jumpToFileTag("test"),
    ["<Leader>ms"] = setFileTag("subject"),
    ["<Leader>'s"] = jumpToFileTag("subject"),
    ["<Leader>mw"] = setFileTag("primary"),
    ["<Leader>'w"] = jumpToFileTag("primary"),
    ["<Leader>me"] = setFileTag("secondary"),
    ["<Leader>'e"] = jumpToFileTag("secondary"),
    ["<Leader>mr"] = setFileTag("tertiary"),
    ["<Leader>'r"] = jumpToFileTag("tertiary"),
    ["<Leader>mu"] = setFileTag("scratch"),
    ["<Leader>'u"] = jumpToFileTag("scratch"),
    ["<Leader>ml"] = setFileTag("log"),
    ["<Leader>'l"] = jumpToFileTag("log"),

    -- ISwap
    ["Q"] = { "<cmd>ISwapWith<cr>" },
    [">p"] = { "<cmd>ISwapWithRight<cr>", desc = "Swap node with right" },
    ["<p"] = { "<cmd>ISwapWithLeft<cr>", desc = "Swap node with left" }, -- better search
    n = { utils.better_search("nzz"), desc = "Next search" },
    N = { utils.better_search("Nzz"), desc = "Previous search" }, -- quick save

    -- CLI TUIs
    ["<F8>"] = { name = "CLI TUIs" },
    ["<Leader>dt"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "dart tinker" }) end,
      desc = "Toggleterm Artisan tinker for current Docker container",
    },
    ["<Leader>db"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "dbash" }) end,
      desc = "Toggleterm Bash for current Docker container",
    },
    ["<Leader>gg"] = {
      function()
        local current_branch = git_utils.get_git_branch()
        local worktree = astro.file_worktree()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
        or ""
        astro.toggle_term_cmd(
          {
            cmd = "lazygit " .. flags,
            direction = "float",
            on_close = function ()
              local new_branch = git_utils.get_git_branch()

              if new_branch ~= current_branch then
                git_utils.signal_branch_change()
              end
            end
          }
        )
      end,
      desc = "ToggleTerm lazygit",
    },
    ["<Leader>tg"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "gh dash" }) end,
      desc = "Toggleterm Github Dash",
    },
    ["<Leader>tn"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "lazynpm" }) end,
      desc = "Toggleterm LazyNPM",
    },
    ["<Leader>ty"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "yazi" }) end,
      desc = "Toggleterm Yazi",
    },
    ["<F3>"] = {
      function() astro.toggle_term_cmd({ direction = "float", cmd = "cursor-agent", count = 9 }) end,
      desc = "Toggleterm Cursor Agent",
    },

    -- Telescope
    ["<Leader>ff"] = {
      function()
        require("snacks").picker.files({
          hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
          include = {
            '.env',
          },
          exclude = search_exclusions,
        })
      end,
      desc = "Find files",
    },
    ["<Leader>fw"] = {
      function() require("snacks").picker.grep {
        hidden = true,
        ignored = true,
          exclude = search_exclusions,
      } end,
      desc = "Find words in all files",
    },
    ["<Leader>f/"] = { function() require("snacks").picker.grep({
      glob = {
        vim.fn.expand("%")
      }
    }) end, desc = "Find words" },
    ["<Leader>fo"] = {
      function() require("telescope.builtin").oldfiles({ cwd_only = true }) end,
      desc = "Find history",
    },
    ["<Leader>fH"] = {
      function()
        vim.ui.select(
          {
            "vendor",
            "node_modules",
          },
          {
            prompt = "Select an ignored directory:",
          },
          function(selection)
            require("telescope.builtin").find_files({
              prompt_title = selection .. "Files",
              cwd = vim.fn.getcwd() .. "/" .. selection,
              follow = true,
            })
          end
        )
      end,
      desc = "Find in node_modules",
    },
    ["<Leader>fd"] = { "<cmd>Telescope dir live_grep<CR>", desc = "Find words in directory" },
    ["<Leader>fe"] = { function() require("config.pickers.env").read_env() end, desc = "Find env values" },

    X = { "x~", desc = "Delete current character and capitalize the next" },
    ["<C-i>"] = { "<C-i>zz", desc = "Jump forward and center" },
    ["<C-o>"] = { "<C-o>zz", desc = "Jump backward and center" },

    ["<LocalLeader>e"] = { "<cmd>e<CR>", desc = "Copy file path" },

    ["<F2>"] = { function() file_utils.toggle_source_test() end, desc = "Toggle between test and source file" },

    -- Copying
    ["<LocalLeader>y"] = { name = "󰆏 Copy..." },
    ["<LocalLeader>yp"] = { function() vim.fn.setreg("+", vim.fn.expand("%:p:.")) end, desc = "Copy file path" },
    ["<LocalLeader>yd"] = { function() vim.fn.setreg("+", vim.fn.expand("%:h")) end, desc = "Copy directory path" },
    ["<LocalLeader>yf"] = { function() vim.fn.setreg("+", vim.fn.expand("%:t:r")) end, desc = "Copy file name" },

    -- Local Git Operations
    ["<LocalLeader>g"] = { name = "󰊢 Git..." },
    ["<LocalLeader>go"] = { function() require("snacks").gitbrowse() end, desc = "Copy file path" },

    -- Scratch
    ["<LocalLeader>s"] = { name = "Scratch files" },
    ["<LocalLeader>sn"] = {
      "<cmd>Scratch<CR>",
      desc = "Open new scratch file",
    },
    ["<LocalLeader>st"] = {
      function()
        vim.ui.select(vim.g.scratch_config.filetypes, {
          prompt = "Extension",
        }, function(extension)
          if extension ~= nil then
            vim.ui.input({
              prompt = "File name:",
            }, function(file_name)
              if file_name ~= nil then
                require("scratch").scratchByName(file_name .. "." .. extension)
              else
                require("scratch").scratchByType(extension)
              end
            end)
          end
        end)
      end,
      desc = "Open and name a new scratch file",
    },
    ["<LocalLeader>sf"] = {
      "<cmd>ScratchOpen<CR>",
      desc = "Find a scratch file",
    },
    ["<LocalLeader>s/"] = {
      "<cmd>ScratchOpenFzf<CR>",
      desc = "Search through all scratch files",
    },

    -- TreeSJ
    ["<LocalLeader>j"] = {
      function()
        require('treesj').toggle({ split = { recursive = true } })
      end,
      desc = "TreeSJ join",
    },

    -- Git
    ["<Leader>gB"] = { "<cmd>G blame<cr>", desc = "Commit annotations" },

    ["<Leader>pa"] = {
      function()
        require("astrocore").update_packages()

        git_utils.commit_lazy_lock_file()
      end,
      desc = "Update Lazy and Mason",
    },

    ["<Leader>pU"] = {
      function()
        require("lazy").update()

        git_utils.commit_lazy_lock_file()
      end,
      desc = "Plugins Update",
    },

    ["ga"] = { "GA", desc = "Start inserting at the end of the last line" },
    ["go"] = { "Go", desc = "Start inserting after the last line" },

    -- Undotree
    ["<Leader>z"] = { name = "Undotree" },
    ["<Leader>zz"] = { function() require("undotree").toggle() end, desc = "Toggle Undotree" },
  },
  i = {
    -- AI
    -- ["<A-CR>"] = { 'copilot#Accept("\\<CR>")', desc = "Accept AI suggestion", expr = true, replace_keycodes = false },

    -- Luasnip
    ["<C-k>"] = {
      function()
        if ls.jumpable(-1) then ls.jump(-1) end
      end,
      desc = "Jump to previous snippet",
      silent = true,
    },
    ["<C-j>"] = {
      function()
        if ls.jumpable() then ls.jump(1) end
      end,
      desc = "Jump to next snippet",
      silent = true,
    },
    ["<C-h>"] = {
      function()
        if ls.choice_active() then ls.change_choice(-1) end
      end,
      desc = "Cycle through active choices",
    },
    ["<C-l>"] = {
      function()
        if ls.choice_active() then ls.change_choice(1) end
      end,
      desc = "Cycle through active choices",
    },
  },
  v = {
    ["<"] = { "<gv", desc = "Unindent without losing selection" },
    [">"] = { ">gv", desc = "Indent without losing selection" },
    ["y"] = { "ymy", desc = "Yank in visual mode without losing cursor position" },
    ["gS"] = { "!jq<CR>", desc = "Format JSON" },
    ["gJ"] = { "!jq<CR>", desc = "Format JSON" },
  },
  t = {
    -- setting a mapping to false will disable it
    ["<F8>"] = { "<C-\\><C-n>" },
  },
}
