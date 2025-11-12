-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    ensure_installed = {
      "bash",
      "c",
      "dockerfile",
      "graphql",
      "html",
      "javascript",
      "json",
      "lua",
      "php",
      "query",
      "scss",
      "tmux",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
      -- add more arguments for adding more treesitter parsers
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>ss",
        node_incremental = "<leader>si",
        scope_incremental = "<leader>sc",
        node_decremental = "<leader>sd",
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
	      enable = true,
	      set_jumps = true, -- whether to set jumps in the jumplist
	      goto_next_start = {
	        ["]m"] = "@function.outer",
	        ["]]"] = "@class.outer",
	      },
	      goto_next_end = {
	        ["]M"] = "@function.outer",
	        ["]["] = "@class.outer",
	      },
	      goto_previous_start = {
	        ["[m"] = "@function.outer",
	        ["[["] = "@class.outer",
	      },
	      goto_previous_end = {
	        ["[M"] = "@function.outer",
	        ["[]"] = "@class.outer",
	      },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
}
