-- https://github.com/vscode-langservers/vscode-json-languageserver
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jsonls = {
        settings = {
          schemas = {
            { fileMatch = { "jsconfig.json" }, url = "https://json.schemastore.org/jsconfig" },
            { fileMatch = { "tsconfig.json" }, url = "https://json.schemastore.org/tsconfig" },
            { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package" },
            {
              fileMatch = { ".prettierrc.json", ".prettierrc" },
              url = "https://json.schemastore.org/prettierrc.json",
            },
            { fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
          },
        },
      },
    },
  },
}
