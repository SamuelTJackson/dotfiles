local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>ca",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end,
    { silent = true, buffer = bufnr }
)
vim.keymap.set(
    "n",
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    { silent = true, buffer = bufnr }
)

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.rs",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = {
            only = { "quickfix" },
            diagnostics = vim.tbl_map(function(d)
                return d.user_data.lsp
            end, vim.diagnostic.get(0)),
            triggerKind = 1,
        }
        params.range = {
            start = { line = 0, character = 0 },
            ["end"] = { line = #vim.api.nvim_buf_get_lines(0, 0, -1, false), character = 0 },
        }
        vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result, context, config)
            for _, action in ipairs(result or {}) do
                if action.title == "Remove all the unused imports" then
                    local client = vim.lsp.get_client_by_id(context.client_id)
                    client.request("codeAction/resolve", action, function(err_resolve, resolved_action)
                        if err_resolve then
                            vim.notify(err_resolve.code .. ": " .. err_resolve.message, vim.log.levels.ERROR)
                            return
                        end
                        if resolved_action.edit then
                            vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
                        end
                    end)
                    return
                end
            end
        end)
    end,
})
