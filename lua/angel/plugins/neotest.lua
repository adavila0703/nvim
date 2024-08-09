return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-plenary",
      "fredrikaverpil/neotest-golang",
      'nvim-neotest/neotest-jest',
    },
    config = function()
      local neotest = require("neotest")


      neotest.setup({
        adapters = {
          require("neotest-vitest"),
          require("neotest-plenary").setup({
            -- this is my standard location for minimal vim rc
            -- in all my projects
            min_init = "./scripts/tests/minimal.vim",
          }),
          require("neotest-golang"),
          require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        }
      })

      vim.keymap.set("n", "<leader>tc", function()
        neotest.run.run()
      end)
    end,
  },
}
