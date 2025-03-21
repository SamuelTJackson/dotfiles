return {
    "rafaelsq/nvim-goc.lua",

    config = function()
        local goc = require 'nvim-goc'
        goc.setup({ verticalSplit = false }) -- default to horizontal

        vim.keymap.set('n', '<Leader>gcf', goc.Coverage, { silent = true })
        vim.keymap.set('n', '<Leader>gcc', goc.ClearCoverage, { silent = true })
    end
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
}
