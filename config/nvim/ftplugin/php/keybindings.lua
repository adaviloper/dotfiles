local astrocore = require("astrocore")

astrocore.set_mappings({
  n = {
    -- NeoTeset
    ["<F4>"] = { name = "Testing" },
    ["<F4><F4>"] = {
      function() require("php-dev-tools.test_utils").test_last_test() end,
      desc = "Rerun the previous test",
    },
    ["<F4>n"] = {
      function() require("php-dev-tools.test_utils").test_nearest_method() end,
      desc = "Run nearest test",
    },
    ["<F4>f"] = {
      function() require("php-dev-tools.test_utils").test_current_file() end,
      desc = "Test the entire file",
    },
    ["<F4>g"] = { function() require("php-dev-tools.test_utils").test_group() end, desc = "Select a group to test" },

    -- Laravel.nvim
    ["<Leader>fl"] = { name = "Laravel" },
    ["<Leader>fll"] = { "<cmd>Laravel artisan<CR>", desc = "Laravel picker" },
    ["<Leader>fla"] = { "<cmd>Laravel artisan<CR>", desc = "Laravel artisan commands" },
    ["<Leader>flr"] = { "<cmd>Laravel routes<CR>", desc = "Laravel artisan routes" },
    ['<Leader>flc'] = { "<cmd>Laravel commands<cr>", desc = "Laravel commands" },
    ['<Leader>flm'] = { "<cmd>Laravel make<cr>", desc = "Laravel routes" },

    -- Phpactor.nvim
    ['<LocalLeader>p'] = { name = "Phpactor.nvim mappings" },
    ['<LocalLeader>pc'] = { '<cmd>PhpactorContextMenu<cr>', desc = "Context Menu" },
    ['<LocalLeader>pt'] = { '<cmd>PhpactorTransform<cr>', desc = "Transform file" },

  },
  v = {
    ['<LocalLeader>xv'] = { '<cmd>ExtractToVariable<cr>', desc = "Extract to a variable" },
  },
})
