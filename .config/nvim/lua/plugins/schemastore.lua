--- https://github.com/b0o/SchemaStore.nvim
---@type LazySpec
return {
  "b0o/schemastore.nvim",
  specs = {
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        ---@diagnostic disable: missing-fields
        config = {
          jsonls = {
            before_init = function(_, config)
              if not config.settings.json.schemas then config.settings.json.schemas = {} end
              vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = { json = { validate = { enable = true } } },
          },
          yamlls = {
            before_init = function(_, config)
              config.settings.yaml.schemas =
                vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
            end,
            settings = {
              redhat = { telemetry = { enabled = false } },
              yaml = { schemaStore = { enable = false, url = "" } },
            },
          },
        },
      },
    },
  },
}
