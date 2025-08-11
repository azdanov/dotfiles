--- https://github.com/jay-babu/mason-nvim-dap.nvim
---@type LazySpec
return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      js = function()
        local dap = require "dap"
        dap.adapters["pwa-node"] = {
          type = "server",
          port = "${port}",
          executable = { command = vim.fn.exepath "js-debug-adapter", args = { "${port}" } },
        }
        require("dap.ext.vscode").type_to_filetypes["pwa-node"] =
          { "javascript", "javascriptreact", "typescript", "typescriptreact" }

        local pwa_node_attach = {
          type = "pwa-node",
          request = "launch",
          name = "js-debug: Attach to Process (pwa-node)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        }
        local function typescript(args)
          return {
            type = "pwa-node",
            request = "launch",
            name = ("js-debug: Launch Current File (ts-node%s)"):format(
              args and (" " .. table.concat(args, " ")) or ""
            ),
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "ts-node",
            runtimeArgs = args,
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            resolveSourceMapLocations = {
              "${workspaceFolder}/dist/**/*.js",
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          }
        end
        for _, language in ipairs { "javascript", "javascriptreact" } do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "js-debug: Launch File (pwa-node)",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            pwa_node_attach,
          }
        end
        for _, language in ipairs { "typescript", "typescriptreact" } do
          dap.configurations[language] = {
            typescript(),
            typescript { "--esm" },
            pwa_node_attach,
          }
        end
      end,
    },
  },
}
