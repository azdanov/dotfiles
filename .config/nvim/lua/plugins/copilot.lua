---@type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    version = false,
    dependencies = {
      { "zbirenbaum/copilot.lua", optional = true, enabled = false },
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
            ["grug-far"] = false,
            ["grug-far-history"] = false,
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
}
