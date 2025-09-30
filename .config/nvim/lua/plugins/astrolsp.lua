--- https://github.com/AstroNvim/astrolsp
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = { "sqruff" },
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
  },
}
