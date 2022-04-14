local lspconfig = require 'lspconfig'

-- Diagnostics
pcall(require, 'nvim-ale-diagnostic')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  underline = { severity_limit = "Error" },
  signs = true,
  update_in_insert = false,
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = 'single',
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

-- vim.lsp.handlers['textDocument/formatting'] = vim.lsp.with(vim.lsp.buf.formatting, {
--   insertSpaces = true,
-- })

-- Code action popup
-- but only use it if installed
local success_lsputils, lsputils_codeAction = pcall(require, 'lsputil.codeAction')
if success_lsputils then
  if vim.fn.has('nvim-0.6') == 1 then
    vim.lsp.handlers['textDocument/codeAction'] = lsputils_codeAction.code_action_handler
  else
    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
      lsputils_codeAction.code_action_handler(nil, actions, nil, nil, nil)
    end
  end
end

local function lsp_map(mode, left_side, right_side)
  vim.api.nvim_buf_set_keymap(vim.api.nvim_get_current_buf(), mode, left_side, right_side, { noremap = true })
end

local function on_attach(client)
  print('Attaching to ' .. client.name)

  lsp_map('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
  lsp_map('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>')
  lsp_map('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
  lsp_map('n', 'gw',         '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  lsp_map('n', 'gW',         '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  lsp_map('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  lsp_map('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  lsp_map('n', 'gn',         '<cmd>lua vim.diagnostic.goto_next()<CR>')
  lsp_map('n', 'gN',         '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  lsp_map('n', '<leader>le', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  lsp_map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  lsp_map('n', '<leader>w',  '<cmd>lua vim.lsp.buf.formatting_sync()<CR><cmd>w<CR>')

  -- Replacement for lspsaga
  local diag_opts = '{ width = 80, focusable = false, border = "single" }'
  lsp_map('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
  lsp_map('n', '<c-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  lsp_map('n', '<leader>o', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  lsp_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  lsp_map('n', '<leader>ls', '<cmd>lua vim.diagnostic.open_float('.. diag_opts ..')<CR>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Only load cmp lsp capabilities when avaiabled
-- in case you uninstall nvim-cmp
local success_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if success_cmp_lsp then
  capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Language Servers
lspconfig.jedi_language_server.setup(default_config)
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        composites = false,
      },
    },
  },
  -- default_config
  on_attach = on_attach,
  capabilities = capabilities,
})
-- lspconfig.eslint.setup(default_config)

--[[
-- Lua language server
local root_pattern = require 'lspconfig'.util.root_pattern

local lua_rtp = vim.split(package.path, ';')
table.insert(lua_rtp, 'lua/?.lua')
table.insert(lua_rtp, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup(vim.tbl_extend('force', default_config, {
  cmd = {'luals'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_rtp,
      },
      diagnostics = { globals = {'vim'} },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
  root_dir = root_pattern('.luals'),
})) ]]
function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local M = {}

M.on_attach = on_attach
M.capabilities = capabilities

return M
