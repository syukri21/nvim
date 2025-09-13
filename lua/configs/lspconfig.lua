-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "cssls", "lua_ls", "marksman", "eslint", "ts_ls", "html", "jsonls", "rust_analyzer", "intelephense" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.html.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "html", "jinja", "htmldjango" },
}
-- configuring single server, example: typescript
lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        features = "ssr",
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}

lspconfig.intelephense.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}


lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
--
-- vim.filetype.add {
--   extension = {
--     jinja = "jinja",
--     jinja2 = "jinja",
--     j2 = "jinja",
--     jinja_html = "jinja",
--     html = "jinja",
--   },
-- }

-- -- if you want to debug
-- vim.lsp.set_log_level "debug"
--
-- local configs = require "lspconfig.configs"
-- if not configs.jinja_lsp then
--   configs.jinja_lsp = {
--     default_config = {
--       name = "jinja-lsp",
--       cmd = { "path_to_lsp_or_command" },
--       filetypes = { "html", "jinja", "rust" },
--       root_dir = function(fname)
--         return "."
--         --return nvim_lsp.util.find_git_ancestor(fname)
--       end,
--       init_options = {
--         templates = "./templates",
--         backend = { "./src" },
--         lang = "rust",
--       },
--     },
--   }
-- end
-- lspconfig.jinja_lsp.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = { "html", "jinja" },
-- }
