require("samueltjackson.set")
require("samueltjackson.remap")
require("samueltjackson.lazy_init")

local augroup = vim.api.nvim_create_augroup
local SamuelTJacksonGroup = augroup("SamuelTJackson", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
local tele = require("telescope.builtin")

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
autocmd({ "BufWritePre" }, {
    group = SamuelTJacksonGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = "",
    }
    vim.lsp.buf.execute_command(params)
end

autocmd("LspAttach", {
    group = SamuelTJacksonGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        local filetype = vim.bo[e.buf].filetype

        vim.keymap.set("n", "gd", function()
            tele.lsp_definitions()
        end, opts)
        vim.keymap.set("n", "gi", function()
            tele.lsp_implementations()
        end, opts)
        vim.keymap.set("n", "gr", function()
            tele.lsp_references()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>ws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>sd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>ca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set("n", "<leader>nd", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "<leader>pd", function()
            vim.diagnostic.goto_prev()
        end, opts)

        if filetype == "typescriptreact" then
            vim.keymap.set("n", "<leader>i", organize_imports)
        end

        vim.keymap.set("n", "<leader>vr", function()
            vim.lsp.buf.rename()
        end, opts)
        -- Filetype-specific keymap
        if filetype == "go" then
            vim.keymap.set("n", "<leader>i", "<cmd>GoImportRun<CR>")
        end
    end,
})

autocmd("FocusGained", {
    callback = function()
        local closedBuffers = {}
        vim.iter(vim.api.nvim_list_bufs())
            :filter(function(bufnr)
                local valid = vim.api.nvim_buf_is_valid(bufnr)
                local loaded = vim.api.nvim_buf_is_loaded(bufnr)
                return valid and loaded
            end)
            :filter(function(bufnr)
                local bufPath = vim.api.nvim_buf_get_name(bufnr)
                local doesNotExist = vim.loop.fs_stat(bufPath) == nil
                local notSpecialBuffer = vim.bo[bufnr].buftype == ""
                local notNewBuffer = bufPath ~= ""
                return doesNotExist and notSpecialBuffer and notNewBuffer
            end)
            :each(function(bufnr)
                local bufName = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
                table.insert(closedBuffers, bufName)
                vim.api.nvim_buf_delete(bufnr, { force = true })
            end)
    end,
})

-- Override tab width for JavaScript files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "javascript",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
