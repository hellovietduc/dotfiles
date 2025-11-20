return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        scope = { enabled = true },
      },
    },
  },
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
  {
    "saghen/blink.indent",
    enabled = false,
    event = "LazyFile",
    opts = {
      blocked = {
        -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
        buftypes = { include_defaults = false },
        -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
        filetypes = { include_defaults = false },
      },
      scope = {
        char = "│",
        highlights = {
          "BlinkIndentScope",
        },
      },
    },
  },
}
