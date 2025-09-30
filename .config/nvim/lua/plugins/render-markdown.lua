--- https://github.com/MeanderingProgrammer/render-markdown.nvim
---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = "RenderMarkdown",
  ft = "markdown",
  ---@module 'render-markdown'
  ---@type render.md.Config
  ---@diagnostic disable: missing-fields
  opts = {
    completions = { lsp = { enabled = true } },
    sign = { enabled = false },
    code = { border = "thin" },
  },
}
