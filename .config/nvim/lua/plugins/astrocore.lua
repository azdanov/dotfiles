---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    filetypes = {
      extension = {
        pcss = "postcss",
        postcss = "postcss",
        mdx = "markdown.mdx",
      },
      filename = {
        ["docker-compose.yaml"] = "yaml.docker-compose",
      },
    },
  },
}
