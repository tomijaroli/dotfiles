return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
      },
    },
    config = function()
      require "plugins.config.debuger"
    end,
  },
}
