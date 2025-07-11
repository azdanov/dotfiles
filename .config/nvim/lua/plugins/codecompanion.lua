-- https://github.com/olimorris/codecompanion.nvim/discussions/640#discussioncomment-12866279
local Spinner = {
  processing = false,
  spinner_index = 1,
  namespace_id = nil,
  timer = nil,
  spinner_symbols = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  },
  filetype = "codecompanion",
}

function Spinner:get_buf(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then return buf end
  end
  return nil
end

function Spinner:update_spinner()
  if not self.processing then
    self:stop_spinner()
    return
  end

  self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1

  local buf = self:get_buf(self.filetype)
  if buf == nil then return end

  -- Clear previous virtual text
  vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)

  local last_line = vim.api.nvim_buf_line_count(buf) - 1
  vim.api.nvim_buf_set_extmark(buf, self.namespace_id, last_line, 0, {
    virt_lines = { { { self.spinner_symbols[self.spinner_index] .. " Processing...", "Comment" } } },
    virt_lines_above = true, -- false means below the line
  })
end

function Spinner:start_spinner()
  self.processing = true
  self.spinner_index = 0

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  self.timer = vim.loop.new_timer()
  self.timer:start(0, 100, vim.schedule_wrap(function() self:update_spinner() end))
end

function Spinner:stop_spinner()
  self.processing = false

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  local buf = self:get_buf(self.filetype)
  if buf == nil then return end

  vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)
end

function Spinner:init()
  -- Create namespace for virtual text
  self.namespace_id = vim.api.nvim_create_namespace "CodeCompanionSpinner"

  vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        self:start_spinner()
      elseif request.match == "CodeCompanionRequestFinished" then
        self:stop_spinner()
      end
    end,
  })
end

---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "ravitemer/mcphub.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "User AstroFile",
        opts = {},
      },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          Spinner:init()

          if not opts.mappings then opts.mappings = {} end

          local prefix = "<Leader>A"

          opts.mappings.n[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }
          opts.mappings.v[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }

          opts.mappings.n[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
          opts.mappings.v[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }

          opts.mappings.n[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
          opts.mappings.v[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }

          opts.mappings.n[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
          opts.mappings.v[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }

          opts.mappings.v[prefix .. "a"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to chat" }

          -- Expand cc to CodeCompanion in cmdline mode
          vim.cmd [[cab cc CodeCompanion]]
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { CodeCompanion = "󱙺" } } },
    },
    event = "User AstroFile",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
      strategies = {
        chat = {
          keymaps = {
            send = {
              callback = function(chat)
                -- https://github.com/olimorris/codecompanion.nvim/discussions/640#discussioncomment-12866279
                vim.cmd "stopinsert"
                chat:submit()
                chat:add_buf_message { role = "llm", content = "" }
              end,
              index = 1,
              description = "Send",
            },
          },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.file_types then opts.file_types = { "markdown" } end
      opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
    end,
  },
}
