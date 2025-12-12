return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for icons
    config = function()
        local oil = require("oil")

        -- ---------------------------------------------------------
        -- Custom Function: Create Python Module (Folder + __init__.py)
        -- ---------------------------------------------------------
        local function create_python_module()
            local current_dir = oil.get_current_dir()

            vim.ui.input({ prompt = "New Python Module Name: " }, function(name)
                if not name or name == "" then return end

                -- Build paths
                local module_path = current_dir .. name
                local init_path = module_path .. "/__init__.py"

                -- Create directory (0777 octal = 511 decimal)
                local success, err = vim.uv.fs_mkdir(module_path, 511)
                if not success then
                    vim.notify("Error creating directory: " .. err, vim.log.levels.ERROR)
                    return
                end

                -- Create empty __init__.py
                local file = io.open(init_path, "w")
                if file then
                    file:close()
                    vim.notify("Created module: " .. name, vim.log.levels.INFO)
                    -- Refresh Oil view
                    oil.open(current_dir)
                else
                    vim.notify("Error creating __init__.py", vim.log.levels.ERROR)
                end
            end)
        end

        -- ---------------------------------------------------------
        -- Main Configuration
        -- ---------------------------------------------------------
        oil.setup({
            -- Oil will take over directory buffers (e.g. `nvim .` or `:e src/`)
            default_file_explorer = true,

            -- Send deleted files to trash instead of permanent delete (Safety net)
            delete_to_trash = true,

            -- Skip the confirmation popup for simple file name changes
            skip_confirm_for_simple_edits = true,

            -- UI Settings
            view_options = {
                show_hidden = true,             -- Show .gitignore, .env, etc.
                natural_order = true,           -- Sort intuitively (1.py, 2.py, 10.py)
                is_always_hidden = function(name, bufnr)
                    return name == ".." or name == ".git" -- Hide parent dir and .git folder
                end,
            },

            -- Visual Columns
            columns = {
                "icon", -- Show file icons
                -- "permissions",
                -- "size",
                -- "mtime",
            },

            -- Keymaps inside the Oil Buffer
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_split", -- Open in horizontal split
                ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
                ["<C-p>"] = "actions.preview", -- Preview file under cursor
                ["<C-c>"] = "actions.close", -- Close Oil
                ["-"] = "actions.parent",    -- Go up one directory
                ["_"] = "actions.open_cwd",  -- Open CWD
                ["`"] = "actions.cd",        -- Change global directory to current Oil dir
                ["~"] = "actions.tcd",       -- Change tab directory
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external", -- Open in OS (e.g. Finder/Explorer)
                ["<leader>pm"] = {
                    callback = create_python_module,
                    desc = "Create Python Module (__init__.py)",
                    mode = "n",
                },
            },
        })

        -- ---------------------------------------------------------
        -- Global Keymap to Open Oil
        -- ---------------------------------------------------------
        -- Use `-` to open oil in the current directory
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" })
    end
}

