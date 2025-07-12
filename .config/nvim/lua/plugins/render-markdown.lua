---@see https://github.com/MeanderingProgrammer/render-markdown.nvim
---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = "RenderMarkdown",
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["render-markdown.nvim"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    return opts.file_types or { "markdown" }
  end,
  opts = {
    completions = { lsp = { enabled = true } },
    pipe_table = { enabled = false },
    sign = { enabled = false },
  },
}
