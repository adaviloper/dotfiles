-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    ensure_installed = {
      "c",
      "javascript",
      "lua",
      "query",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
      -- add more arguments for adding more treesitter parsers
    },
    highlight = {
      additional_vim_regex_highlighting = true,
      enable = true,
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
    },
  },
}
