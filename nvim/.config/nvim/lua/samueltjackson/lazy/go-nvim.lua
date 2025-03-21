return {
    'ray-x/go.nvim',
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio'

    },
    ft = { 'go', 'gomod' },
    config = function()
        require('go').setup()
    end
}
