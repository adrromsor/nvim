return {
    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
            },
        },
        keys = {
            { "<leader>gj", function() require("gitsigns").next_hunk() end,    desc = "Next Hunk" },
            { "<leader>gk", function() require("gitsigns").prev_hunk() end,    desc = "Prev Hunk" },
            { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
            { "<leader>gr", function() require("gitsigns").reset_hunk() end,   desc = "Reset Hunk" },
            { "<leader>gb", function() require("gitsigns").blame_line() end,   desc = "Blame Line" },
        },
    },

    -- Lazygit
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
        },
    },

    -- Diffview
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff View Open" },
            { "<leader>gD", "<cmd>DiffviewClose<cr>",         desc = "Diff View Close" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
        },
    },
}
