--- https://github.com/nvim-neo-tree/neo-tree.nvim
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/neo-tree.lua
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      group_empty_dirs = true,
      scan_mode = "deep",
      filtered_items = {
        hide_dotfiles = false,
        always_show = { ".env", ".github", ".gitignore" },
        hide_by_name = { ".git" },
      },
    },
    window = {
      width = 28,
      mappings = {
        ["z"] = "none",
      },
    },
    nesting_rules = {
      env = {
        pattern = "^.env$",
        ignore_case = true,
        files = { ".env", ".env.*" },
      },
      docker = {
        pattern = "^dockerfile$",
        ignore_case = true,
        files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
      },
      git_files = {
        pattern = "^%.gitignore$",
        files = { ".git-blame*", ".gitattributes", ".gitmessage", ".gitmodules", ".mailmap" },
      },
      readme = {
        pattern = "^readme.*",
        ignore_case = true,
        files = {
          "authors",
          "backers*",
          "changelog*",
          "citation*",
          "code_of_conduct*",
          "codeowners",
          "contributing*",
          "contributors",
          "copying*",
          "credits",
          "governance.md",
          "history.md",
          "license*",
          "maintainers",
          "readme*",
          "security.md",
          "sponsors*",
        },
      },
    },
  },
}
