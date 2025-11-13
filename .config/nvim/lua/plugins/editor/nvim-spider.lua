-- better w, e, b motions
return {
  "chrisgrieser/nvim-spider",
  event = "LazyFile",
  opts = {
    -- only use this plugin for the skipInsignificantPunctuation feature
    -- I'm too used to the original motions
    skipInsignificantPunctuation = true,
    consistentOperatorPending = false,
    subwordMovement = false,
  },
}
