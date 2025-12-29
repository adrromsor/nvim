local M = {}

M.on_attach = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    local bufnr = event.buf

    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, {
            buffer = bufnr,
            noremap = true,
            silent = true,
            desc = "LSP: " .. desc,
        })
    end

    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    
    map("<leader>gS", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
    end, "Goto Definition (Split)")

    map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostic")

    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")

    map("<leader>oi", function()
        vim.lsp.buf.code_action({
            context = {
                only = { "source.organizeImports" },
                diagnostics = {},
            },
            apply = true,
        })
    end, "Organize Imports")
end

return M