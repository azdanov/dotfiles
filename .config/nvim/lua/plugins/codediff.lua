--- https://github.com/esmuellert/codediff.nvim
--- https://code.mehalter.com/mehalter/nvim/src/branch/v6/lua/plugins/codediff.lua
---@type LazySpec
local prefix = "<Leader>D"
return {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  opts = {
    explorer = {
      view_mode = "tree",
    },
    diff = {
      hide_merge_artifacts = true,
    },
    keymaps = {
      view = {
        next_hunk = "]C",
        prev_hunk = "[C",
        next_file = "]D",
        prev_file = "[D",
        diff_get = prefix .. "o",
        diff_put = prefix .. "p",
        accept_current = prefix .. "o",
      },
      conflict = {
        accept_incoming = prefix .. "t",
        accept_current = prefix .. "o",
        accept_both = prefix .. "a",
        discard = prefix .. "b",
        next_conflict = "]C",
        prev_conflict = "[C",
        diffget_incoming = prefix .. "T",
        diffget_current = prefix .. "O",
      },
    },
  },
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
                for _, origin in ipairs { "origin/main", "origin/master" } do
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
