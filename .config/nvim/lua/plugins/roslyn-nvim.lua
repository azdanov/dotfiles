--- https://github.com/seblyng/roslyn.nvim
---@type LazySpec
return {
  "seblyng/roslyn.nvim",
  -- .cshtml is detected as filetype `razor` by Neovim, so this also covers it
  ft = { "cs", "razor" },
  dependencies = {
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        autocmds = {
          roslyn_diagnostics_on_insert_leave = {
            cond = function(client) return client.name == "roslyn" end,
            {
              event = "InsertLeave",
              desc = "Refresh Roslyn diagnostics on insert leave",
              callback = function()
                for _, client in ipairs(vim.lsp.get_clients { name = "roslyn" }) do
                  for buf in pairs(client.attached_buffers) do
                    if vim.api.nvim_buf_is_loaded(buf) then
                      client:request(
                        "textDocument/diagnostic",
                        { textDocument = vim.lsp.util.make_text_document_params(buf) },
                        nil,
                        buf
                      )
                    end
                  end
                end
              end,
            },
          },
        },
      },
    },
  },
}
