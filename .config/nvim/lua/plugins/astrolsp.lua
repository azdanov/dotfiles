local progress_ids = {}

--- https://github.com/AstroNvim/astrolsp
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = false,
    },
    autocmds = {
      eslint_fix_on_save = {
        cond = function(client) return client.name == "eslint" and vim.fn.exists ":LspEslintFixAll" > 0 end,
        {
          event = "BufWritePost",
          desc = "Fix all eslint errors",
          callback = function(args)
            if vim.F.if_nil(vim.b[args.buf].autoformat, vim.g.autoformat, true) then vim.cmd.LspEslintFixAll() end
          end,
        },
      },
    },
    -- https://github.com/seblyng/roslyn.nvim/wiki
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
    roslyn_restore_progress = {
      cond = function(client) return client.name == "roslyn" end,
      {
        event = "User",
        pattern = "RoslynRestoreProgress",
        desc = "Show Roslyn restore progress",
        callback = function(ev)
          local token = ev.data.params[1]
          local state = ev.data.params[2].state
          local message = ev.data.params[2].message

          progress_ids[token] = vim.api.nvim_echo({ { message or state } }, false, {
            id = progress_ids[token] or ("roslyn.restore." .. token),
            kind = "progress",
            source = "roslyn",
            title = state,
            status = "running",
          })
        end,
      },
      {
        event = "User",
        pattern = "RoslynRestoreResult",
        desc = "Show Roslyn restore result",
        callback = function(ev)
          local token = ev.data.token
          local id = progress_ids[token]
          progress_ids[token] = nil

          if id then
            vim.api.nvim_echo({ { ev.data.err and ev.data.err.message or "Restore completed" } }, false, {
              id = id,
              kind = "progress",
              source = "roslyn",
              title = "Restore",
              status = ev.data.err and "failed" or "success",
              percent = 100,
            })
          end
        end,
      },
    },
  },
}
