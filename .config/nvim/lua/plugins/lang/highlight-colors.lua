---@type LazySpec
return {
  "brenoprata10/nvim-highlight-colors",
  event = "User AstroFile",
  cmd = "HighlightColors",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>uz"] = { function() vim.cmd.HighlightColors "Toggle" end, desc = "Toggle color highlight" },
          },
        },
      },
    },
  },
  opts = {
    enabled_named_colors = false,
  },
}
