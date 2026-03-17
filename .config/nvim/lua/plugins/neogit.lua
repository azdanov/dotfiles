--- https://github.com/NeogitOrg/neogit
--- https://code.mehalter.com/mehalter/nvim/src/branch/v6/lua/plugins/neogit.lua
---@type LazySpec
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  opts = {
    -- disable_signs = true,
    -- mappings = {
    --   status = {
    --     ["<S-Tab>"] = "Close",
    --   },
    -- },
    integrations = {
      snacks = true,
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>gG"] = { function() vim.cmd.Neogit() end, desc = "Neogit" },
            ["<S-Tab>"] = { function() vim.cmd.Neogit() end, desc = "Neogit" },
            ["<Leader>gn"] = { function() vim.cmd.Neogit "commit" end, desc = "New Git commit" },
          },
        },
      },
    },
  },
}
