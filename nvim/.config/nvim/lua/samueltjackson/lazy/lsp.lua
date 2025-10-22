return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp",
    },
    config = function()
        local capabilities                 = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol
            .make_client_capabilities())

        vim.lsp.config["buf_ls"]           = {
            capabilities = capabilities,
        }
        vim.lsp.config["htmx"]             = {
            capabilities = capabilities,
            filetypes = { "html", "templ" },
        }
        vim.lsp.config["tailwindcss"]      = {
            filetypes = { "templ", "astro", "javascript", "typescript", "react" },
            init_options = { userLanguages = { templ = "html" } },
        }

        --lspconfig.ts_ls.setup({})
        vim.lsp.config["golangci_lint_ls"] = {}
        vim.lsp.config["typos_lsp"]        = {}
        vim.lsp.config["lua_ls"]           = {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                    },
                },
            },
        }
        vim.lsp.config["gopls"]            = {
            on_attach = function()
                vim.keymap.set("n", "<leader>t", "<cmd>GoTestFile<CR>")
                vim.keymap.set("n", "<leader>fs", "<cmd>GoFillStruct<CR>")
                vim.keymap.set("n", "<leader>ta", "<cmd>GoAddTest<CR>")
            end,
            capabilities,
            settings = {
                gopls = {
                    analyses = {
                        ST1003 = false,
                        fieldalignment = false,
                        fillreturns = true,
                        nilness = true,
                        nonewvars = true,
                        shadow = false,
                        undeclaredname = true,
                        unreachable = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true
                    },
                    buildFlags = { "-tags", "integration,fixtures" },
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true
                    },
                    completeUnimported = true,
                    gofumpt = false,
                    hints = {
                        assignVariableTypes = false,
                        compositeLiteralFields = false,
                        compositeLiteralTypes = false,
                        constantValues = false,
                        functionTypeParameters = true,
                        parameterNames = false,
                        rangeVariableTypes = true
                    },
                    ["local"] = "...",
                    matcher = "Fuzzy",
                    semanticTokens = false,
                    staticcheck = true,
                    symbolMatcher = "fuzzy",
                    usePlaceholders = true
                },
            },
        }
    end
}
