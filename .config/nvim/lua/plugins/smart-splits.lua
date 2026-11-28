--- https://github.com/smart-splits-nvim/smart-splits.nvim
--- smart-splits v3 moved multiplexer/terminal support out of the core plugin into backend plugins,
--- so the Kitty pane navigation that v2 auto-detected now needs an explicit backend.
--- The backend reads an IS_NVIM startup variable, so smart-splits must not be lazy loaded.
--- Delete this file to go back to AstroNvim's core-only (Neovim splits only) setup.
---@type LazySpec
return {
  "smart-splits-nvim/smart-splits.nvim",
  lazy = false,
  dependencies = {
    {
      "smart-splits-nvim/backend-kitty",
      module = "smart-splits-backend-kitty",
      -- uncomment to also install the Kitty kitten/mapping for relative window resizing
      -- build = "./kitten/install_relative_resize.lua",
      opts = {
        -- kitty `remote_control_password` support; kitty.conf currently sets none
        -- password = "secret",
      },
    },
  },
  opts = { mux = { backend = "smart-splits-backend-kitty" } },
}
