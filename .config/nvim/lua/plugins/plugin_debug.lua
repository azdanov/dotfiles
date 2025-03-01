local function debug_plugin_opts()
  local lazy_plugins = require("lazy").plugins()
  local plugin_names = {}

  for _, plugin in pairs(lazy_plugins) do
    table.insert(plugin_names, plugin[1])
  end

  table.sort(plugin_names)

  vim.ui.select(plugin_names, {
    prompt = "Select plugin to debug:",
    format_item = function(plugin_name)
      local name = plugin_name:match "[^/]+$" or plugin_name
      return name .. " (" .. plugin_name .. ")"
    end,
  }, function(plugin_name)
    if not plugin_name then return end
    local name = plugin_name:match "[^/]+$" or plugin_name

    local ok, plugin_opts = pcall(function() return require("astrocore").plugin_opts(name) end)

    if not ok then
      vim.notify("Error retrieving plugin options: " .. plugin_name, vim.log.levels.ERROR)
      return
    end

    vim.cmd "enew"

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = false

    vim.api.nvim_buf_set_name(0, "Plugin Debug: " .. plugin_name)

    local header = "-- Plugin Options for: " .. plugin_name
    local inspected = vim.split("return " .. vim.inspect(plugin_opts), "\n")

    local lines = { header }
    vim.list_extend(lines, inspected)

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.bo.filetype = "lua"

    vim.notify("Loaded options for " .. plugin_name, vim.log.levels.INFO)
  end)
end

return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<Leader>pd"] = {
          debug_plugin_opts,
          desc = "Debug plugin options",
        },
      },
    },
  },
}
