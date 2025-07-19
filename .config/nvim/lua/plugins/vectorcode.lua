---@see https://github.com/Davidyz/VectorCode
---@type LazySpec
return {
  "Davidyz/VectorCode",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "VectorCode",
  specs = {
    {
      "olimorris/codecompanion.nvim",
      optional = true,
      ---@module "codecompanion"
      ---@module "vectorcode"
      opts = {
        extensions = {
          vectorcode = {
            ---@type VectorCode.CodeCompanion.ExtensionOpts
            opts = {
              tool_group = {
                enabled = true,
                extras = { "file_search" },
                collapse = false,
              },
              tool_opts = {
                ---@type VectorCode.CodeCompanion.ToolOpts
                ["*"] = {},
                ---@type VectorCode.CodeCompanion.LsToolOpts
                ls = {},
                ---@type VectorCode.CodeCompanion.VectoriseToolOpts
                vectorise = {},
                ---@type VectorCode.CodeCompanion.QueryToolOpts
                query = {
                  max_num = { chunk = -1, document = -1 },
                  default_num = { chunk = 50, document = 10 },
                  include_stderr = false,
                  use_lsp = false,
                  no_duplicate = true,
                  chunk_mode = false,
                  ---@type VectorCode.CodeCompanion.SummariseOpts
                  ---@diagnostic disable-next-line: missing-fields
                  summarise = {
                    ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                    enabled = false,
                    adapter = nil,
                    query_augmented = true,
                  },
                },
                files_ls = {},
                files_rm = {},
              },
            },
          },
        },
      },
    },
  },
}
