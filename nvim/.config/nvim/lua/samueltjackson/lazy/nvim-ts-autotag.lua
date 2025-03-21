return {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "templ" },
    config = function()
        require("nvim-ts-autotag").setup()
    end
}
