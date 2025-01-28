---@type LazySpec
return {
  { "tpope/vim-rsi", event = { "CmdlineEnter", "InsertEnter" } },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      if require("astrocore").is_available "fzf-lua" then
        local maps = opts.mappings
        if maps.n.gd then
          maps.n.gd[1] = function() require("fzf-lua").lsp_definitions { jump_to_single_result = true } end
        end
      end
    end,
  },
}
