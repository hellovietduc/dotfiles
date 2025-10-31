return {
  "neovim/nvim-lspconfig",
  opts = {
    -- no inlay hints
    inlay_hints = { enabled = false },

    -- no inline diagnostics
    diagnostics = { virtual_text = false },

    servers = {
      ["*"] = {
        keys = {

          -- disable K for hover (reserved for fast up)
          -- see keymaps.lua
          { "K", false },

          -- use gh for hover / diagnostic
          {
            "gh",
            function()
              local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
              if #diagnostics > 0 then
                vim.diagnostic.open_float()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = "Show Info/Diagnostic",
          },

          -- use gH only for hover
          { "gH", vim.lsp.buf.hover, desc = "Show Info" },
        },
      },
    },
  },
}
