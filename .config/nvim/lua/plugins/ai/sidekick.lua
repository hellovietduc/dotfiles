return {
  "folke/sidekick.nvim",
  keys = {
    { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
  },
}
