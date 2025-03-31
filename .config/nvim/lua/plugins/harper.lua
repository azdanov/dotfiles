---Retrieves an LSP client by name
---@param name string
---@return vim.lsp.Client | nil
local function getLSPClient(name) return vim.lsp.get_clients({ bufnr = 0, name = name })[1] end

---Toggles an LSP client by name
---@param name string
---@return nil
local function toggleLSPClient(name)
  local client = getLSPClient(name)
  if client then
    client.stop(true)
  else
    vim.cmd("LspStart " .. name)
  end
end

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        harper_ls = {
          autostart = false,
        },
      },
      mappings = {
        n = {
          ["<leader>uG"] = {
            function() toggleLSPClient "harper_ls" end,
            desc = "Toggle Grammar Checker",
          },
        },
      },
    },
  },
}
