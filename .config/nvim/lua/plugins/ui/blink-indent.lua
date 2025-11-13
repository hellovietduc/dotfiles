return {
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
  {
    "saghen/blink.indent",
    event = "LazyFile",
    opts = {
      scope = {
        char = "│",
        highlights = {
          "BlinkIndentScope",
        },
      },
    },
  },
}
