return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for icons
    config = function()
        local oil = require("oil")

        local function create_python_module()
            local current_dir = oil.get_current_dir()
            if not current_dir then return end

            vim.ui.input({ prompt = "Create python module: " }, function(name)
                if not name or name == "" then return end

                -- Build the full path relative to the directory currently open in Oil
                local full_path = current_dir .. name

                -- Get the parent directory of the new file
                local parent_dir = vim.fn.fnamemodify(full_path, ":h")

                -- RECURSIVE MAGIC: Create all missing parent folders automatically
                if vim.fn.isdirectory(parent_dir) == 0 then
                    vim.fn.mkdir(parent_dir, "p") -- "p" flag = mkdir -p
                end

                -- Create and open the file
                vim.cmd.edit(full_path)
                vim.cmd.write() -- Save immediately to ensure it exists on disk
            end)
        end

        oil.setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".." or name == ".git" or name == "__pycache__"
                end,
            },
            columns = {
                "icon",
            },
            keymaps = {

                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_split",  -- Open in horizontal split
                ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
                ["<C-p>"] = "actions.preview",       -- Preview file under cursor
                ["<C-c>"] = "actions.close",         -- Close Oil
                ["-"] = "actions.parent",            -- Go up one directory
                ["_"] = "actions.open_cwd",          -- Open CWD
                ["`"] = "actions.cd",                -- Change global directory to current Oil dir
                ["~"] = "actions.tcd",               -- Change tab directory
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",    -- Open in OS (e.g. Finder/Explorer)
                ["<leader>pm"] = {
                    callback = create_python_module,
                    desc = "Create Python Module",
                    mode = "n",
                },
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["R"] = "actions.refresh", -- Refresh Oil
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" })
    end
}
