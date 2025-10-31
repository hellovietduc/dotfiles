-- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12289384
local Format = require("noice.text.format")
local Message = require("noice.message")
local Manager = require("noice.message.manager")
local Router = require("noice.message.router")

local ThrottleTime = 200
local Notifier = {}

Notifier.handles = {}
function Notifier.init()
  local group = vim.api.nvim_create_augroup("NoiceCompanionRequests", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local handle = Notifier.create_progress_message(request)
      Notifier.store_progress_handle(request.data.id, handle)
      Notifier.update(handle)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      local message = Notifier.pop_progress_message(request.data.id)
      if message then
        message.opts.progress.message = Notifier.report_exit_status(request)
        Notifier.finish_progress_message(message)
      end
    end,
  })
end

function Notifier.store_progress_handle(id, handle)
  Notifier.handles[id] = handle
end

function Notifier.pop_progress_message(id)
  local handle = Notifier.handles[id]
  Notifier.handles[id] = nil
  return handle
end

function Notifier.create_progress_message(request)
  local msg = Message("lsp", "progress")
  local id = request.data.id
  msg.opts.progress = {
    client_id = "client " .. id,
    client = Notifier.llm_role_title(request.data.adapter),
    id = id,
    message = "Awaiting Response: ",
  }
  return msg
end

function Notifier.update(message)
  if Notifier.handles[message.opts.progress.id] then
    Manager.add(Format.format(message, "lsp_progress"))
    vim.defer_fn(function()
      Notifier.update(message)
    end, ThrottleTime)
  end
end

function Notifier.finish_progress_message(message)
  Manager.add(Format.format(message, "lsp_progress"))
  Router.update()
  Manager.remove(message)
end

function Notifier.llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

function Notifier.report_exit_status(request)
  if request.data.status == "success" then
    return "Completed"
  elseif request.data.status == "error" then
    return " Error"
  else
    return "󰜺 Cancelled"
  end
end

local function send_keys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

-- Only use this plugin for the inline assistant. Use case:
-- 1. Select code
-- 2. Press <D-i> and prompt the edit
-- 3. Review and accept
-- Can look into Sidekick.nvim to replace it but now the benefit of this is
-- I can choose a non-thinking model for faster response time.
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/noice.nvim",
    },
    init = function()
      Notifier:init()
    end,
    opts = {
      adapters = {
        claude_thinking = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:cat /Users/vietduc/.claude_token",
            },
          })
        end,
        claude_non_thinking = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:cat /Users/vietduc/.claude_token",
            },
            schema = {
              model = {
                default = "claude-haiku-4-5",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "claude_thinking",
        },
        inline = {
          adapter = "claude_non_thinking",
        },
      },
      display = {
        chat = {
          show_token_count = false,
          start_in_insert_mode = true,
        },
        diff = {
          opts = { "internal", "filler", "closeoff", "iwhite", "algorithm:patience", "indent-heuristic" },
        },
      },
    },
    keys = {
      {
        "<D-i>",
        function()
          send_keys(":CodeCompanion ")
        end,
        desc = "Inline Assistant",
        mode = { "v" },
      },
    },
  },

  -- Improve markdown rendering in Code Companion buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
