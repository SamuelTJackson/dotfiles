return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            pickers = {
                find_files = {
                    find_command = { 'rg', '--no-ignore', '--files', '--hidden', '-g', '!.git', '-g', '!**/node_modules/*', '-g', '!*.lock', '-g', '!**zig-cache/*', '-g', '!**zig-out/*', },
                    hidden = true
                },
                grep_string = {
                    additional_args = { '--no-ignore', "--hidden", '--files', '-g', '!.git', '-g', '!**/node_modules/*', '-g', '!*.lock', }
                },
                live_grep = {
                    additional_args = { '--no-ignore', "-u", "--hidden", '-g', '!.git', '-g', '!**/node_modules/*', '-g', '!*.lock', }
                },
            },
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    },
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
}
