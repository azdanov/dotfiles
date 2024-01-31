vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

local set_mappings = function(bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "Format current buffer" })

  nmap("<leader>cf", "<cmd>Format<CR>", "Format")

  nmap("<leader>dn", vim.diagnostic.goto_next, "Go to next diagnostic")
  nmap("<leader>dp", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  nmap("<leader>dl", vim.diagnostic.setloclist, "Set diagnostic list")
  nmap("<leader>df", vim.diagnostic.open_float, "Open diagnostic float")

  nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Action")

  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gr", function()
    require("telescope.builtin").lsp_references({ layout_strategy = "vertical" })
  end, "Goto References")
  nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("gt", vim.lsp.buf.type_definition, "Type Definition")
  nmap("gs", function()
    require("telescope.builtin").lsp_document_symbols({ layout_strategy = "vertical" })
  end, "Document Symbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation")

  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("<leader>ws", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols({ layout_strategy = "vertical" })
  end, "Symbols")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List Folders")
end

return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lua" },
    -- Snippets
    { "L3MON4D3/LuaSnip", version = "V2.*" },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(_, bufnr)
      set_mappings(bufnr)
    end)

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {},
      handlers = {
        lsp_zero.default_setup,
      },
    })

    local cmp = require("cmp")

    cmp.setup({
      formatting = lsp_zero.cmp_format(),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lua" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-f>"] = lsp_zero.cmp_action().luasnip_jump_forward(),
        ["<C-b>"] = lsp_zero.cmp_action().luasnip_jump_backward(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      }),
    })
  end,
}
