-- popup code actions
return {
  "Chaitanyabsprip/fastaction.nvim",
  event = "LazyFile",
  ---@type FastActionConfig
  opts = {
    dismiss_keys = { "j", "k", "q", "<esc>" },
    register_ui_select = true,
  },
}
