local shared = require "shared"

---@type LazySpec
return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "User AstroFile",
    init = function()
      vim.g.copilot_filetypes = {
        markdown = true,
        ["grug-far"] = false,
        ["grug-far-history"] = false,
      }
    end,
    dependencies = {
      {
        "Saghen/blink.cmp",
        ---@param opts blink.cmp.Config
        opts = function(_, opts)
          if not opts.keymap then opts.keymap = {} end
          opts.keymap["<Tab>"] = {
            function()
              if vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
                vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "n", true)
                return true
              else
                return false
              end
            end,
            "select_next",
            "snippet_forward",
            function(cmp)
              if shared.has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
            end,
            "fallback",
          }
          opts.keymap["<M-]>"] = {
            function() vim.fn["copilot#Next"]() end,
          }
          opts.keymap["<M-[>"] = {
            function() vim.fn["copilot#Previous"]() end,
          }
          opts.keymap["<M-\\>"] = {
            function() vim.fn["copilot#Suggest"]() end,
          }
          opts.keymap["<M-Right>"] = {
            function()
              local copilot_keys = vim.fn["copilot#AcceptWord"]()
              if copilot_keys ~= "" and type(copilot_keys) == "string" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
              end
            end,
          }
          opts.keymap["<M-C-Right>"] = {
            function()
              local copilot_keys = vim.fn["copilot#AcceptLine"]()
              if copilot_keys ~= "" and type(copilot_keys) == "string" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
              end
            end,
          }
          opts.keymap["<C-]>"] = {
            function() vim.fn["copilot#Dismiss"]() end,
          }
        end,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatDebugInfo",
      "CopilotChatModels",
      "CopilotChatAgents",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatFixTests",
      "CopilotChatCommit",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "AstroNvim/astroui", opts = { icons = { CopilotChat = "" } } },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = opts.options.g.copilot_chat_prefix or "<Leader>P"
          local astroui = require "astroui"

          maps.n[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }
          maps.v[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }

          maps.n[prefix .. "o"] = { ":CopilotChatOpen<CR>", desc = "Open Chat" }
          maps.n[prefix .. "c"] = { ":CopilotChatClose<CR>", desc = "Close Chat" }
          maps.n[prefix .. "t"] = { ":CopilotChatToggle<CR>", desc = "Toggle Chat" }
          maps.n[prefix .. "r"] = { ":CopilotChatReset<CR>", desc = "Reset Chat" }
          maps.n[prefix .. "s"] = { ":CopilotChatStop<CR>", desc = "Stop Chat" }

          maps.n[prefix .. "S"] = {
            function()
              vim.ui.input({ prompt = "Save Chat: " }, function(input)
                if input ~= nil and input ~= "" then require("CopilotChat").save(input) end
              end)
            end,
            desc = "Save Chat",
          }

          maps.n[prefix .. "L"] = {
            function()
              local copilot_chat = require "CopilotChat"
              local path = copilot_chat.config.history_path
              local chats = require("plenary.scandir").scan_dir(path, { depth = 1, hidden = true })
              -- Remove the path from the chat names and .json
              for i, chat in ipairs(chats) do
                chats[i] = chat:sub(#path + 2, -6)
              end
              vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
                if selected ~= nil and selected ~= "" then copilot_chat.load(selected) end
              end)
            end,
            desc = "Load Chat",
          }

          local function get_active_picker()
            if
              require("astrocore").is_available "snacks.nvim"
              and (function()
                local snacks = require "snacks.picker"
                return snacks.config and snacks.config.ui_select
              end)()
            then
              return "snacks"
            elseif require("astrocore").is_available "fzf-lua" then
              return "fzflua"
            elseif require("astrocore").is_available "telescope.nvim" then
              return "telescope"
            end

            return nil
          end

          local function create_mapping(action_type, selection_type)
            return function()
              local actions = require "CopilotChat.actions"
              local items = actions[action_type] { selection = require("CopilotChat.select")[selection_type] }
              if not items then
                vim.notify(
                  "No " .. action_type:gsub("_", " ") .. " found for the current selection",
                  vim.log.levels.WARN
                )
                return
              end

              local picker = get_active_picker()
              if not picker then
                vim.notify(
                  "No valid picker is enabled. Please enable one of telescope, fzf-lua, or snacks.",
                  vim.log.levels.ERROR
                )
                return
              end

              local ok, picker_module = pcall(require, "CopilotChat.integrations." .. picker)
              if not ok then
                vim.notify(
                  ("Integration module '%s' for picker '%s' is not available. Ensure it is installed and enabled."):format(
                    picker,
                    picker
                  ),
                  vim.log.levels.WARN
                )
                return
              end

              picker_module.pick(items)
            end
          end

          maps.n[prefix .. "p"] = {
            create_mapping("prompt_actions", "buffer"),
            desc = "Prompt actions",
          }

          maps.v[prefix .. "p"] = {
            create_mapping("prompt_actions", "visual"),
            desc = "Prompt actions",
          }

          local function quick_chat(selection_type)
            return function()
              vim.ui.input({ prompt = "Quick Chat: " }, function(input)
                if input ~= nil and input ~= "" then
                  require("CopilotChat").ask(input, { selection = require("CopilotChat.select")[selection_type] })
                end
              end)
            end
          end

          maps.n[prefix .. "q"] = {
            quick_chat "buffer",
            desc = "Quick Chat",
          }

          maps.v[prefix .. "q"] = {
            quick_chat "visual",
            desc = "Quick Chat",
          }
        end,
      },
    },
    opts = {},
  },
}
