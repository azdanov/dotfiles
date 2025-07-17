---@see https://github.com/Civitasv/cmake-tools.nvim
---@type LazySpec
return {
  "Civitasv/cmake-tools.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "codelldb" })
      end,
    },
  },
  opts = {},
}
