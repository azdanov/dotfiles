local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@type LazySpec
return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "User AstroFile",
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        g = {
          copilot_filetypes = {
            markdown = true,
            ["grug-far"] = false,
            ["grug-far-history"] = false,
          },
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    version = false,
    dependencies = {
      { "zbirenbaum/copilot.lua", optional = true, enabled = false },
    },
  },
  {
    "Saghen/blink.cmp",
    optional = true,
    ---@module "blink-cmp"
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
          if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
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
}
