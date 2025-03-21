return {
    "mattn/vim-goaddtags",
    ft = { "go" },
    config = function()
        -- enable auto format when write (default)
        vim.g.go_addtags_transform = "camelcase"

        vim.keymap.set("n", "<leader>rt", "<cmd>GoRemoveTags<CR>")
        vim.keymap.set("n", "<leader>at", function()
            local input = vim.fn.input("Tag name: ")
            vim.cmd(":w")
            vim.cmd(":GoAddTags " .. input)
        end)
    end,
}
