return {
  { "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate", opts = {} },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
        vim.keymap.set(
          "n",
          "<leader>dp",
          vim.diagnostic.goto_prev,
          { buffer = bufnr, desc = "Go to previous diagnostic" }
        )
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Set diagnostic list" })
        vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { buffer = bufnr, desc = "Open diagnostic float" })

        vim.keymap.set("x", "<leader>cf", "<cmd>Format<CR>", { buffer = bufnr, desc = "Format" })
        vim.keymap.set("n", "<leader>cf", "<cmd>Format<CR>", { buffer = bufnr, desc = "Format" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Action" })
        vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Action" })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition" })
        vim.keymap.set("n", "gr", function()
          require("telescope.builtin").lsp_references({ layout_strategy = "vertical" })
        end, { buffer = bufnr, desc = "Goto References" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto Implementation" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
        vim.keymap.set("n", "gs", function()
          require("telescope.builtin").lsp_document_symbols({ layout_strategy = "vertical" })
        end, { buffer = bufnr, desc = "Document Symbols" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
        vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto Declaration" })
        vim.keymap.set("n", "<leader>ws", function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({ layout_strategy = "vertical" })
        end, { buffer = bufnr, desc = "Symbols" })
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add Folder" })
        vim.keymap.set(
          "n",
          "<leader>wr",
          vim.lsp.buf.remove_workspace_folder,
          { buffer = bufnr, desc = "Remove Folder" }
        )
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = bufnr, desc = "List Folders" })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
}
