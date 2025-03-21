return {
    "hrsh7th/nvim-cmp",
    opts = {
        mapping = {
            ["<C-u>"] = function()
                require("luasnip").jump(1)
            end,
            ["<C-y>"] = function()
                require("luasnip").jump(-1)
            end,
        },
    },
}
