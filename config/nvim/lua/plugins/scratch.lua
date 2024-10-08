return {
  "LintaoAmons/scratch.nvim",
  event = "VeryLazy",
  -- version = "v0.13.2"
  opts = {
    file_picker = 'telescope',
    filetypes = {
      "blade.php",
      "conf",
      "css",
      "html",
      "js",
      "json",
      "jsx",
      "lua",
      "md",
      "php",
      "sass",
      "scss",
      "sh",
      "spec.js",
      "spec.ts",
      "toml",
      "ts",
      "tsx",
      "txt",
      "vue",
      "yaml",
      "yml",
      "zsh",
    },
    use_telescope = true,
    window_cmd = 'rightbelow vsplit',
  },
}

