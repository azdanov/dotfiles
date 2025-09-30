local function to_uri(filepath)
  filepath = vim.fs.normalize(filepath)
  local absolute_path = vim.fn.fnamemodify(filepath, ":p")
  return vim.uri_from_fname(absolute_path)
end

--- https://github.com/AstroNvim/astrolsp
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = { "sqruff" },
    autocmds = {
      attach_css_custom_data = {
        cond = function(client) return client.name == "cssls" end,
        {
          event = "LspAttach",
          desc = "Attach custom data for CSS",
          callback = function(args)
            local success = vim.lsp.buf_notify(args.buf, "css/customDataChanged", {
              { to_uri "~/.config/nvim/misc/tailwind.json" },
            })
            if success then
              vim.defer_fn(function()
                vim.diagnostic.reset(nil, args.buf)
                vim.lsp.buf.document_highlight()
              end, 0)
            end
          end,
        },
      },
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
      no_insert_inlay_hints = {
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            if vim.lsp.inlay_hint.is_enabled(filter) then
              vim.lsp.inlay_hint.enable(false, filter)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
    },
  },
}
