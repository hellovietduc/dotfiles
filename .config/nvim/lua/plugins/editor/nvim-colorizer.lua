return {
  "NvChad/nvim-colorizer.lua",
  event = "LazyFile",
  opts = {
    filetypes = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    user_default_options = {
      tailwind = "both", -- TODO: my TW lsp not working so not work yet
    },
  },
}
