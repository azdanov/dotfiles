--- https://github.com/nvim-mini/mini.icons
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/mini-icons.lua
---@type LazySpec
return {
  "nvim-mini/mini.icons",
  opts = {
    file = {
      [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
      [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
      [".nvmrc"] = { glyph = "", hl = "MiniIconsGreen" },
      [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
      ["bun.lock"] = { glyph = "", hl = "MiniIconsYellow" },
      ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
      ["eslint.config.mjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
      ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
      ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
      ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
      ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
    },
    filetype = {
      gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
    },
  },
}
