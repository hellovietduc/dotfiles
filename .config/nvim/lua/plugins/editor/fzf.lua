if true then
  return {}
end

-- prefills the prompt with cwd so that cwd files are boosted in git files search
-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#prioritize-cwd-when-using-git_files
local function git_files_cwd_aware(opts)
  opts = opts or {}
  local fzf_lua = require("fzf-lua")
  local path = require("fzf-lua.path")
  -- git_root() will warn us if we're not inside a git repo
  -- I want to avoid the error message so I pass `true`
  local git_root = fzf_lua.path.git_root(opts, true)
  if not git_root then
    return require("fzf-lua").files()
  end
  local relative = path.relative_to(vim.loop.cwd(), git_root)
  opts.fzf_opts = { ["--query"] = git_root ~= relative and relative or nil }
  return fzf_lua.git_files(opts)
end

-- https://github.com/ibhagwan/fzf-lua/blob/1ac27d5734ccd057ef2b46a8644022913f37b89e/lua/fzf-lua/actions.lua#L754
local function git_stash_apply_or_create(selected, opts)
  local actions = require("fzf-lua.actions")
  local path = require("fzf-lua.path")
  local utils = require("fzf-lua.utils")
  if #selected == 0 then
    local query = opts.__call_opts.query
    local cmd = path.git_cwd({ "git", "stash", "push", "-u", "-m", query }, opts)
    local output, rc = utils.io_systemlist(vim.deepcopy(cmd))
    if rc ~= 0 then
      utils.err(unpack(output) or string.format("exit code %d", rc))
    end
    -- trigger autoread or warn the users buffer(s) was changed
    vim.cmd("checktime")
  else
    actions.git_stash_apply(selected, opts)
  end
end

local function git_discard_everything()
  if vim.fn.confirm("Discard all changes?", "&Yes\n&No") == 1 then
    local path = require("fzf-lua.path")
    local utils = require("fzf-lua.utils")
    local cmd = path.git_cwd({ "git", "restore", "." }, {})
    local output, rc = utils.io_systemlist(vim.deepcopy(cmd))
    if rc ~= 0 then
      utils.err(unpack(output) or string.format("exit code %d", rc))
    end
    -- trigger autoread or warn the users buffer(s) was changed
    vim.cmd("checktime")
  end
end

return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local actions = require("fzf-lua.actions")
    return vim.tbl_deep_extend("force", opts, {
      fzf_opts = {
        ["--cycle"] = true, -- allow cycling first last results
      },

      -- TODO: move this to its own file
      file_ignore_patterns = {
        "%-lock%.json",
        "yarn%.lock",
        "%.js%.map",
        "beethoven/bh%g-/lib",
        "disco/assets/vendor",
        "infrastructure/beanstalk%-console/public",
        "rails/app/assets/javascripts/translations",
        "rails/app/javascript/vendor",
        "rails/locale/intl_",
        "rails/public/pdfjs",
        "rails/vendor",
        "universal%-post%-editor/intl%g-%.json",
      },

      -- use `bat` as previewer
      -- https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/profiles/fzf-native.lua
      winopts = { preview = { default = "bat_native" } },
      lsp = { code_actions = { previewer = "codeaction_native" } },

      -- set bat theme
      previewers = { bat = { theme = "tokyonight_moon" } },

      -- disable git icons
      -- hide :: character from header: https://github.com/ibhagwan/fzf-lua/issues/1351
      files = { git_icons = false, header_prefix = "" },
      grep = { git_icons = false, header_prefix = "" },

      git = {
        files = { git_icons = false },
        branches = { preview = false, header_prefix = "" }, -- branches previews aren't really helpful
        stash = {
          header_prefix = "",
          actions = {
            ["enter"] = git_stash_apply_or_create,
            ["ctrl-p"] = { fn = actions.git_stash_pop, header = "pop stash", reload = true },
            ["ctrl-d"] = { fn = actions.git_stash_drop, header = "drop stash", reload = true },
            ["ctrl-x"] = false,
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>fb", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>sb", false },
  },
}
