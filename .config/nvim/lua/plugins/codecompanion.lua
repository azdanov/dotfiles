---@see https://github.com/olimorris/codecompanion.nvim
---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          if not opts.mappings then opts.mappings = {} end

          local prefix = "<Leader>A"

          opts.mappings.n[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }
          opts.mappings.v[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }

          opts.mappings.n[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
          opts.mappings.v[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }

          opts.mappings.n[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
          opts.mappings.v[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }

          opts.mappings.n[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
          opts.mappings.v[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }

          opts.mappings.v[prefix .. "a"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to chat" }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { CodeCompanion = "󱙺" } } },
    },
    event = "User AstroFile",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    opts = {
      extensions = {
        spinner = {},
        history = {
          enabled = true,
          opts = {
            expiration_days = 30,
            auto_generate_title = true,
            title_generation_opts = {
              adapter = "copilot",
              model = "gpt-4.1",
              refresh_every_n_prompts = 3,
              max_refreshes = 10,
            },
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            summary = {
              generation_opts = {
                adapter = "copilot",
                model = "gpt-4.1",
                context_size = 90000,
                include_references = true,
                include_tool_outputs = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.file_types then opts.file_types = { "markdown" } end
      opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
    end,
  },
}
