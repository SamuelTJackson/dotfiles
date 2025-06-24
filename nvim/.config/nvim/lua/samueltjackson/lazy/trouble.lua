return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
    opts = {
        auto_open = false,  -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        focus = true,
        modes = {
            lsp = {
                focus = false,
                win = { position = "left", size = 60 },
            },
            symbols = {
                focus = false,
                win = { position = "left", size = 60 },
            },
        },
    },
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Trouble: Diagnostics",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble: DBuffer Diagnostics",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle<cr>",
            desc = "Trouble: DSymbols",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle<cr>",
            desc = "Trouble: DLSP Definitions / references",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Trouble: DLocation List",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Trouble: Quickfix List",
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)
        local open_with_trouble = require("trouble.sources.telescope").open

        local telescope = require("telescope")
        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

        telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<c-t>"] = open_with_trouble },
                    n = { ["<c-t>"] = open_with_trouble },
                },
            },
        })
    end,
}
