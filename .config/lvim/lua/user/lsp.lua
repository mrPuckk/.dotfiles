----------------------------
---------- LSP  ------------
----------------------------

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    "sumneko_lua",
    "jsonls",
}

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- lvim.lsp.automatic_configuration.skipped_servers = { "pyright" }
-- Server settings
-- $LUNARVIM_CONFIG_DIR/lsp-settings/clangd.json
--
local pyright_opts = {

} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pyright", pyright_opts)

-- -- local clangd_onAttach = {
-- --   vim.lsp.protocol.make_client_capabilities().offsetEncoding {"utf-16"}
-- --   -- cmd = {"/usr/lib/llvm-12/bin/clangd"}
-- -- } -- check the lspconfig documentation for a list of all possible options

 local capabilities = vim.lsp.protocol.make_client_capabilities()
 capabilities.offsetEncoding = {"utf-16"}

 local clangd_onAttach = {
  cmd = {"/usr/bin/clangd"}
 }

 require("lvim.lsp.manager").setup("clangd", clangd_onAttach)
 require('lspconfig').clangd.setup({capabilities = capabilities})

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)
