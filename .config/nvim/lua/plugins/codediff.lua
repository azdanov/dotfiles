--- https://github.com/esmuellert/codediff.nvim
--- https://code.mehalter.com/mehalter/nvim/src/branch/v6/lua/plugins/codediff.lua
---@type LazySpec
local prefix = "<Leader>D"
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {},
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { name = " Diff View" },
            [prefix .. "<CR>"] = { function() vim.cmd.CodeDiff() end, desc = "Open CodeDiff" },
            [prefix .. "h"] = { function() vim.cmd.CodeDiff("file", "HEAD") end, desc = "Open DiffView File History" },
            [prefix .. "o"] = {
              function()
                local branch
                for _, origin in ipairs { "origin/main", "origin/master", "origin/develop" } do
                  if require("astrocore").cmd({ "git", "rev-parse", "--verify", origin }, false) then
                    branch = origin
                    break
                  end
                end
                if branch then
                  vim.cmd.CodeDiff(branch)
                else
                  vim.notify("Unable to identify an origin branch", vim.log.levels.WARN)
                end
              end,
              desc = "Open CodeDiff against origin",
            },
          },
        },
      },
    },
  },
}
