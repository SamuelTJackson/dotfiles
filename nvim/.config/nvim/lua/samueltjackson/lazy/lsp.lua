return {
    "neovim/nvim-lspconfig",
    version = "*",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        vim.filetype.add({ extension = { templ = "templ" } })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("lspconfig").gleam.setup({})
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "bashls",
                "ts_ls",
                "tailwindcss",
                "eslint",
                "gopls",
                "pyright",
                "terraformls",
                "templ",
                "htmx",
                "html",
                "zls",
                "typos_lsp",
                "golangci_lint_ls",
                "buf_ls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["typos_lsp"] = function()
                    require('lspconfig').typos_lsp.setup({
                    })
                end,
                ["html"] = function()
                    require('lspconfig').htmx.setup({
                        capabilities = capabilities,
                        filetypes = { "html", "templ" },
                    })
                end,
                ["htmx"] = function()
                    require('lspconfig').htmx.setup({
                        capabilities = capabilities,
                        filetypes = { "html", "templ" },
                    })
                end,
                ["tailwindcss"] = function()
                    require('lspconfig').tailwindcss.setup({
                        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
                        init_options = { userLanguages = { templ = "html" } },
                    })
                end,
                ["ts_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ts_ls.setup({
                        on_attach = function(client)
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    })
                end,
                ['golangci_lint_ls'] = function()
                    require 'lspconfig'.golangci_lint_ls.setup {}
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup({
                        on_attach = function(client)
                            vim.keymap.set("n", "<leader>t", "<cmd>GoTestFile<CR>")
                            vim.keymap.set("n", "<leader>fs", "<cmd>GoFillStruct<CR>")
                            vim.keymap.set("n", "<leader>ta", "<cmd>GoAddTest<CR>")
                        end,
                        capabilities = capabilities,
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
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = true,
                                    parameterNames = true,
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
                    })
                end,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
        vim.lsp.buf.format({
            filter = function(client)
                return client.name ~= "ts_ls"
            end,
        })
    end,
}
