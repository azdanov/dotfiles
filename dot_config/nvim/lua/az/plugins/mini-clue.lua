return {
  {
    "echasnovski/mini.clue",
    version = false,
    opts = function()
      local mini_clue = require("mini.clue")
      return {
        window = {
          config = {
            width = "auto",
          },
          delay = 500,
          scroll_down = "<C-d>",
          scroll_up = "<C-u>",
        },
        triggers = {
          { mode = "n", keys = "c" },
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          { mode = "i", keys = "<C-x>" },
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          { mode = "n", keys = "<Leader>c", desc = "+Code" },
          { mode = "n", keys = "<Leader>r", desc = "+Registry" },
          { mode = "n", keys = "<Leader>d", desc = "+Diagnostic" },
          { mode = "n", keys = "<Leader>s", desc = "+Search" },
          { mode = "n", keys = "<Leader>f", desc = "+File" },
          { mode = "n", keys = "<Leader>w", desc = "+Workspace" },
          mini_clue.gen_clues.builtin_completion(),
          mini_clue.gen_clues.g(),
          mini_clue.gen_clues.marks(),
          mini_clue.gen_clues.registers(),
          mini_clue.gen_clues.windows(),
          mini_clue.gen_clues.z(),
        },
      }
    end,
    config = function(_, opts)
      require("mini.clue").setup(opts)
    end,
  },
}
