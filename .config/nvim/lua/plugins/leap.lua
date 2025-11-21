--- https://github.com/ggandor/leap.nvim
---@type LazySpec
return {
  "ggandor/leap.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
            ["gs"] = { "<Plug>(leap-from-window)", desc = "Leap from Window" },
          },
          x = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
          o = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
        },
      },
    },
  },
  config = function()
    -- Exclude whitespace and the middle of alphabetic words from preview:
    --   foobar[baaz] = quux
    --   ^----^^^--^^-^-^--^
    require("leap").opts.preview = function(ch0, ch1, ch2)
      return not (ch1:match "%s" or (ch0:match "%a" and ch1:match "%a" and ch2:match "%a"))
    end

    -- Define equivalence classes for brackets and quotes, in addition to the default whitespace group:
    require("leap").opts.equivalence_classes = {
      " \t\r\n",
      "([{",
      ")]}",
      "'\"`",
    }

    -- Use the traversal keys to repeat the previous motion without explicitly invoking Leap:
    require("leap.user").set_repeat_keys("<enter>", "<backspace>")
  end,
}
