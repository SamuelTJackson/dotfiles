return {
    "rafamadriz/friendly-snippets",
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    config = function()
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
    end,
}
