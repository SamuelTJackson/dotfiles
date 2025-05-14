return {
    "rafamadriz/friendly-snippets",
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.expand("~/.config/nvim/snippets") } })
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
    end,
}
