-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "lua_ls", "marksman", "eslint" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
}

lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

local jdtls_bin = "jdtls"

lspconfig.jdtls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    java = {

      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/opt/openjdk@21",
            default = true,
          },

          {
            name = "JavaSE-17",
            path = "~/.sdkman/candidates/java/17.0.14-tem",
            default = true,
          },

          {
            name = "JavaSE-11",
            path = "~/.sdkman/candidates/java/11.0.25-amzn",
            default = true,
          },
        },
      },
    },
  },
  cmd = {
    jdtls_bin,
    "--jvm-arg=" .. os.getenv "JDTLS_JVM_ARGS",
  },
}
