local null_ls = require("null-ls")
local myLspConfig = require("trash.lsp")

null_ls.setup({
  sources = {
-- lspconfig.jedi_language_server.setup(default_config)
-- lspconfig.bashls.setup(default_config)
-- lspconfig.cssls.setup(default_config)
-- lspconfig.dockerls.setup(default_config)
-- lspconfig.html.setup(default_config)
-- lspconfig.jsonls.setup(default_config)
-- lspconfig.tsserver.setup(default_config)
-- lspconfig.vimls.setup(default_config)
-- lspconfig.yamlls.setup(default_config)
-- lspconfig.gopls.setup(default_config)
    null_ls.builtins.formatting.prettier,
  },
  on_attach = myLspConfig.on_attach,
  capabilities = myLspConfig.capabilities,
})
