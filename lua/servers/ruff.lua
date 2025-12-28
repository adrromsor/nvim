--- @param capabilities table LSP client capabilities
--- @return nil
return function(capabilities)
    vim.lsp.config("ruff", {
        capabilities = capabilities,
        on_attach = function(client)
            -- Disable Ruff's hover so BasedPyright can take priority
            client.server_capabilities.hoverProvider = false
        end,
    })
end
