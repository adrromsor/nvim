--- @param capabilities table LSP client capabilities
--- @return nil
return function(capabilities)
    vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                    typeCheckingMode = "standard",
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    diagnosticSeverityOverrides = {
                        reportUnusedVariable = "none",
                        reportUnusedImport = "none",
                    },
                },
            },
        },
    })
end

