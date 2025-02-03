local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "User AstroFile",
  opts = {
    suggestion = {
      auto_trigger = true,
      debounce = 150,
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = true,
  },
  dependencies = {
    {
      "Saghen/blink.cmp",
      opts = function(_, opts)
        local copilot = require "copilot.suggestion"
        opts.keymap = opts.keymap or {}

        local function copilot_action(action)
          return function()
            if copilot.is_visible() then
              copilot[action]()
              return true
            end
          end
        end

        local keymap = {
          ["<Tab>"] = {
            copilot_action "accept",
            "select_next",
            "snippet_forward",
            function(cmp)
              if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
            end,
            "fallback",
          },
          ["<C-x>"] = { copilot_action "next" },
          ["<C-z>"] = { copilot_action "prev" },
          ["<C-right>"] = { copilot_action "accept_word" },
          ["<C-l>"] = { copilot_action "accept_word" },
          ["<C-down>"] = { copilot_action "accept_line" },
          ["<C-j>"] = { copilot_action "accept_line", "select_next", "fallback" },
          ["<C-c>"] = { copilot_action "dismiss" },
        }

        for k, v in pairs(keymap) do
          opts.keymap[k] = v
        end

        return opts
      end,
    },
  },
}
