return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
  },
  -- AstroNvim already sets up dap-ui and its open/close listeners, so only add adapters here
  config = function (...)
    require("astronvim.plugins.configs.nvim-dap")(...)

    local dap = require('dap')

    require('dap-go').setup()

    -- mason-nvim-dap has no handler for js-debug-adapter, so register pwa-node by hand
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "js-debug-adapter", args = { "${port}" } },
    }

    for _, ft in ipairs({ "typescript", "javascript" }) do
      dap.configurations[ft] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Vitest: current file",
          cwd = "${workspaceFolder}",
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          args = { "run", "${file}", "--no-file-parallelism" },
          autoAttachChildProcesses = true,
          smartStep = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Node: current file",
          cwd = "${workspaceFolder}",
          program = "${file}",
          skipFiles = { "<node_internals>/**" },
        },
      }
    end
  end
}
