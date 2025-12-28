return {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        -- Files & Buffers
        { "<leader>ff", function() require("fzf-lua").files() end, desc = "FZF Files" },
        { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "FZF Live Grep" },
        { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "FZF Buffers" },
        { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "FZF Help Tags" },

        -- Diagnostics
        { "<leader>fx", function() require("fzf-lua").diagnostics_document() end, desc = "FZF Diagnostics Document" },
        { "<leader>fX", function() require("fzf-lua").diagnostics_workspace() end, desc = "FZF Diagnostics Workspace" },

        -- LSP
        { "<leader>fd", function() require("fzf-lua").lsp_finder() end, desc = "FZF LSP Finder" },
        { "<leader>fr", function() require("fzf-lua").lsp_references() end, desc = "FZF References" },
        { "<leader>fi", function() require("fzf-lua").lsp_implementations() end, desc = "FZF Implementations" },
        { "<leader>ft", function() require("fzf-lua").lsp_typedefs() end, desc = "FZF Type Definitions" },
        
        -- Symbols
        { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "FZF Document Symbols" },
        { "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "FZF Workspace Symbols" },
    },
    opts = {},
}