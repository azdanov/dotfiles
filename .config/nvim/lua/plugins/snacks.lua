--- https://github.com/folke/snacks.nvim
---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@module 'snacks'
  ---@type snacks.plugins.Config
  opts = {
    scroll = {},
    picker = {
      win = {
        list = {
          wo = {
            foldcolumn = "0",
          },
        },
        preview = {
          wo = {
            number = false,
            signcolumn = "no",
            foldcolumn = "0",
          },
        },
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>i"] = {
              function()
                local image = require "snacks.image"
                image.doc.hover_close()
                image.hover()
                vim.api.nvim_create_autocmd("CursorMoved", {
                  once = true,
                  group = vim.api.nvim_create_augroup("snacks_image_cleanup", { clear = true }),
                  callback = function() image.doc.hover_close() end,
                })
              end,
              desc = "Hover image",
            },
          },
        },
      },
    },
  },
}
