return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  opts = {
    -- cmdline = { view = "cmdline" },
    messages = { view_search = false },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = false,
      },
      progress = {
        enabled = false,
      },
      signature = {
        enabled = false,
      }
    },
    routes = {
      { filter = { event = "msg_show", cmdline = "^:lua" },          view = "messages" },      -- send lua output to split
      { filter = { event = "msg_show", min_height = 20 },            view = "messages" },      -- send long messages to split
      { filter = { event = "msg_show", find = "AutoSave" },          opts = { skip = true } }, -- skip autosave notifications
      { filter = { event = "msg_show", find = "%d+L,%s%d+B" },       opts = { skip = true } }, -- skip save notifications
      { filter = { event = "msg_show", find = "Hunk %d+ of %d+" },   opts = { skip = true } }, -- skip hunk jumping notifications
      { filter = { event = "msg_show", find = "%d+ lines --%d+%%--" },          opts = { skip = true } }, -- skip autosave notifications
      { filter = { event = "msg_show", find = "^%d+ more lines$" },  opts = { skip = true } }, -- skip paste notifications
      { filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
      {
        filter = { event = "msg_show", find = "^%d+ lines yanked$" },
        opts = { skip = true },
      }, -- skip yank notifications
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = false,      -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  }
}
