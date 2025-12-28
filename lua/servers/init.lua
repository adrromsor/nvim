local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.basedpyright")(capabilities)
require("servers.ruff")(capabilities)


vim.lsp.enable({
    'lua_ls',
    'basedpyright',
    'ruff',
})
