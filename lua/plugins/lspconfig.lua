return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "basedpyright", "ruff", "lua_ls" },
            automatic_installation = true,
        })
        require("utils.diagnostics").setup()
        require("servers")
    end,
}
