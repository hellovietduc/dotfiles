return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",

      -- Don't use <CR> for completion
      ["<CR>"] = { "hide", "fallback" },
    },
  },
}
