-- https://github.com/redhat-developer/yaml-language-server
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        settings = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = ".github/workflow/*.yml",
          },
        },
      },
    },
  },
}
