vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          features = "ssr",
        },
        rustfmt = {
          overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
        },
        diagnostics = {
          disabled = { "proc-macro-disabled", "inactive-code" },
        },
        procMacro = {
          ignored = {
            leptos_macro = {
              -- optional: --
              -- "component",
              "server",
            },
          },
        },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
