-- require "user.lsp.languages.rust"
-- require "user.lsp.languages.go"
-- require "user.lsp.languages.python"
-- require "user.lsp.languages.js-ts"
--require "user.lsp.languages.sh"
--require "user.lsp.languages.emmet"
--require "user.lsp.languages.css"
reload "user.lsp.languages.clangd"

lvim.lsp.diagnostics.virtual_text = false

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    "sumneko_lua",
    "jsonls",
    "clangd"
}

