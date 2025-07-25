local prefix = "<Leader>s"
local default_opts = { instanceName = "main" }

local function grug_far_open(opts, selection)
  local grug_far = require "grug-far"
  opts = require("astrocore").extend_tbl(default_opts, opts)
  if selection then
    if not opts.prefills then opts.prefills = {} end
    if selection == "search" then
      opts.prefills.search = grug_far.get_current_visual_selection(true)
    elseif selection == "paths" then
      opts.prefills.paths = grug_far.get_current_visual_selection_as_range_str(true)
    end
  end
  if not grug_far.has_instance(opts.instanceName) then
    grug_far.open(opts)
  else
    local inst = assert(grug_far.get_instance(opts.instanceName))
    if opts.prefills then inst:update_input_values(opts.prefills, false) end
    inst:open()
  end
end

---@see https://github.com/MagicDuck/grug-far.nvim
---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  opts = {
    transient = true,
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "󰛔 Search/Replace" },
            [prefix .. "s"] = {
              function() grug_far_open() end,
              desc = "Search/Replace workspace",
            },
            [prefix .. "e"] = {
              function()
                local ext = require("astrocore.buffer").is_valid() and vim.fn.expand "%:e" or ""
                grug_far_open {
                  prefills = { filesFilter = ext ~= "" and "*." .. ext or nil },
                }
              end,
              desc = "Search/Replace filetype",
            },
            [prefix .. "f"] = {
              function()
                local filter = require("astrocore.buffer").is_valid() and vim.fn.expand "%" or nil
                grug_far_open { prefills = { paths = filter } }
              end,
              desc = "Search/Replace file",
            },
            [prefix .. "w"] = {
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
            },
          },
          x = {
            [prefix .. "s"] = { function() grug_far_open(nil, "search") end, desc = "Search/Replace selection" },
            [prefix .. "S"] = { function() grug_far_open(nil, "paths") end, desc = "Search/Replace within selection" },
          },
        },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
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
}
