
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang-format", filetypes = {"cpp", "c", "h", "hpp"} },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup{
  { command = "cpplint", filetypes = {"cpp", "c", "h", "hpp"}},
}

-- Add offsetEncoding property in common_capabilities as locally for Clangd
local capabilities = require"lvim.lsp".common_capabilities()
capabilities.offsetEncoding = {"utf-16"}

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("clangd", {
  capabilities = capabilities,
  on_init = require "lvim.lsp".common_on_init,
  on_attach = require "lvim.lsp".common_on_attach
})


