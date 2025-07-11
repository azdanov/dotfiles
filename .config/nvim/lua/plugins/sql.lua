-- Find the applicable SQLFluff configuration path
local function get_config_path()
  local system_config = vim.env.HOME .. "/.sqlfluff"
  local project_config = vim.fn.getcwd() .. "/.sqlfluff"

  local has_project_config = vim.fn.filereadable(project_config) == 1
  local has_system_config = vim.fn.filereadable(system_config) == 1

  if has_project_config then
    return project_config
  elseif has_system_config then
    return system_config
  end

  return nil
end

-- Build arguments for SQLFluff formatting command
local function formatting()
  local config_path = get_config_path()
  local sqlfluff = { "fix" }

  if config_path then
    table.insert(sqlfluff, "--config")
    table.insert(sqlfluff, config_path)
  else
    table.insert(sqlfluff, "--dialect=ansi")
  end

  table.insert(sqlfluff, "-")

  return sqlfluff
end

-- Build arguments for SQLFluff linting command
local function linting()
  local config_path = get_config_path()
  local sqlfluff = { "lint", "--format=json" }

  if config_path then
    table.insert(sqlfluff, "--config")
    table.insert(sqlfluff, config_path)
  end

  return sqlfluff
end

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sql" })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sqlfluff" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          args = formatting(),
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        sqlfluff = {
          args = linting(),
        },
      },
      linters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
}
