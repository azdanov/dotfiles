return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["z"] = "none",
        },
      },
    },
  },
}