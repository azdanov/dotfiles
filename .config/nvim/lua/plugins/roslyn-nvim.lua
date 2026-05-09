local init_handles = {}

--- https://github.com/seblyng/roslyn.nvim
---@type LazySpec
return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    extensions = {
      ---@diagnostic disable-next-line: missing-fields
      razor = {
        enabled = false,
      },
    },
  },
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
                local clients = vim.lsp.get_clients { name = "roslyn" }
                if not clients or #clients == 0 then return end
                local client = clients[1]
                local buffers = vim.lsp.get_client_by_id(client.id).attached_buffers
                for buf, _ in ipairs(buffers) do
                  local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
                  client:request("textDocument/diagnostic", params, nil, buf)
                end
              end,
            },
          },
        },
      },
    },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          roslyn_restore_progress = {
            {
              event = "User",
              pattern = "RoslynOnInit",
              desc = "Show Roslyn restore progress",
              callback = function(ev)
                local message = ev.data.type == "solution"
                    and string.format("Initializing Roslyn for %s", ev.data.target)
                  or "Initializing Roslyn for project"

                init_handles[ev.data.client_id] = vim.api.nvim_echo({ { message } }, false, {
                  id = "roslyn." .. ev.data.client_id,
                  kind = "progress",
                  source = "roslyn",
                  title = "Initializing Roslyn for project",
                  status = "running",
                  percent = 10,
                })
              end,
            },
            {
              event = "User",
              pattern = "RoslynInitialized",
              desc = "Show Roslyn restore result",
              callback = function(ev)
                local handle = init_handles[ev.data.client_id]
                init_handles[ev.data.client_id] = nil

                if handle then
                  vim.api.nvim_echo({ { "Roslyn initialized" } }, false, {
                    id = handle,
                    kind = "progress",
                    source = "roslyn",
                    title = "Initializing Roslyn for project",
                    status = "running",
                    percent = 100,
                  })
                end
              end,
            },
          },
        },
      },
    },
  },
}
