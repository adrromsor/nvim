return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            zen = { enabled = true },
            
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys",  gap = 1, padding = 1 },
                    {
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1
                    },
                    { section = "startup" },
                },
            },
        },
        keys = {
            { "<leader>z", function() Snacks.zen() end,      desc = "Toggle Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        },
    }
}
