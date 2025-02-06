local default_opts = { instanceName = "main" }
local function grug_far_open(opts, with_visual)
  local grug_far = require "grug-far"
  opts = require("astrocore").extend_tbl(default_opts, opts)
  if not grug_far.has_instance(opts.instanceName) then
    grug_far.open(opts)
  else
    if with_visual then
      if not opts.prefills then opts.prefills = {} end
      opts.prefills.search = grug_far.get_current_visual_selection()
    end
    grug_far.open_instance(opts.instanceName)
    if opts.prefills then grug_far.update_instance_prefills(opts.instanceName, opts.prefills, false) end
  end
end

---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  dependencies = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = { icons = { GrugFar = "󰛔" } },
    },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps, prefix = opts.mappings or {}, "<Leader>s"

        maps.n[prefix] = { desc = require("astroui").get_icon("GrugFar", 1, true) .. "Search/Replace" }
        maps.n[prefix .. "s"] = {
          function() grug_far_open() end,
          desc = "Search/Replace workspace",
        }
        maps.n[prefix .. "e"] = {
          function()
            local ext = require("astrocore.buffer").is_valid() and vim.fn.expand "%:e" or ""
            grug_far_open {
              prefills = { filesFilter = ext ~= "" and "*." .. ext or nil },
            }
          end,
          desc = "Search/Replace filetype",
        }
        maps.n[prefix .. "f"] = {
          function()
            local filter = require("astrocore.buffer").is_valid() and vim.fn.expand "%" or nil
            grug_far_open { prefills = { paths = filter } }
          end,
          desc = "Search/Replace file",
        }
        maps.n[prefix .. "w"] = {
          function()
            local current_word = vim.fn.expand "<cword>"
            if current_word ~= "" then
              grug_far_open {
                startCursorRow = 4,
                prefills = { search = vim.fn.expand "<cword>" },
              }
            else
              vim.notify("No word under cursor", vim.log.levels.WARN, { title = "Grug-far" })
            end
          end,
          desc = "Replace current word",
        }
        maps.x[prefix] = { function() grug_far_open(nil, true) end, desc = "Replace selection" }
      end,
    },
    {
      "github/copilot.vim",
      init = function()
        vim.g.copilot_filetypes = {
          ["grug-far"] = false,
          ["grug-far-history"] = false,
        }
      end,
    },
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        if not opts.disable then opts.disable = {} end
        opts.disable.ft = require("astrocore").list_insert_unique(opts.disable.ft, { "grug-far" })
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        commands = {
          grug_far_replace = function(state)
            local node = state.tree:get_node()
            grug_far_open {
              prefills = {
                paths = node.type == "directory" and node:get_id() or vim.fn.fnamemodify(node:get_id(), ":h"),
              },
            }
          end,
        },
        window = {
          mappings = {
            gS = "grug_far_replace",
          },
        },
      },
    },
  },
  ---@param opts GrugFarOptionsOverride
  opts = function(_, opts)
    opts.transient = true
    if not opts.icons then opts.icons = {} end
    if vim.g.icons_enabled == false then
      opts.icons.enabled = false
      opts.resultsSeparatorLineChar = "-"
      opts.spinnerStates = { "|", "\\", "-", "/" }
    end
    if not opts.engines then opts.engines = {} end
    if not opts.engines.astgrep then opts.engines.astgrep = {} end
    opts.engines.astgrep.path = "ast-grep"
  end,
}
