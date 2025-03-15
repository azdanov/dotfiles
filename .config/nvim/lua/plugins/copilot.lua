---@type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    version = false,
    dependencies = {
      { "zbirenbaum/copilot.lua", optional = true, enabled = false },
    },
    opts = {
      model = "claude-3.7-sonnet",
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        g = {
          copilot_workspace_folders = { vim.fn.getcwd() },
          copilot_integration_id = "vscode-chat",
          copilot_settings = { selectedCompletionModel = "gpt-4o-copilot" },
          copilot_filetypes = {
            markdown = true,
          },
        },
      },
      autocmds = {
        copilot_workspaces = {
          {
            event = "DirChanged",
            pattern = "*",
            desc = "Keep Copilot workspace folders updated to current directory",
            callback = function() vim.g.copilot_workspace_folders = { vim.fn.getcwd() } end,
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          path = {
            enabled = function() return vim.bo.filetype ~= "copilot-chat" end,
          },
        },
      },
    },
  },
}
