return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		local caps = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

		vim.lsp.config("*", { capabilities = caps })

		vim.lsp.config("buf_ls", {})

		vim.lsp.config("htmx", {
			filetypes = { "html", "templ" },
		})

		vim.lsp.config("tailwindcss", {
			workspace_required = false,
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css" },
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				on_dir(vim.fs.root(fname, {
					"tailwind.config.js",
					"tailwind.config.ts",
					"tailwind.config.cjs",
				}) or vim.fs.root(fname, { ".git" }))
			end,
			settings = {
				tailwindCSS = {
					classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
					includeLanguages = {
						eelixir = "html-eex",
						eruby = "erb",
						htmlangular = "html",
						templ = "html",
					},
					lint = {
						cssConflict = "warning",
						invalidApply = "error",
						invalidConfigPath = "error",
						invalidScreen = "error",
						invalidTailwindDirective = "error",
						invalidVariant = "error",
						recommendedVariantOrder = "warning",
					},
					validate = true,
				},
			},
		})

		vim.lsp.config("golangci_lint_ls", {})

		vim.lsp.config("typos_lsp", {})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			on_attach = function()
				vim.keymap.set("n", "<leader>t", "<cmd>GoTestFile<CR>")
				vim.keymap.set("n", "<leader>fs", "<cmd>GoFillStruct<CR>")
				vim.keymap.set("n", "<leader>ta", "<cmd>GoAddTest<CR>")
			end,
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
						useany = true,
					},
					buildFlags = { "-tags", "integration,fixtures" },
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
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
						rangeVariableTypes = true,
					},
					["local"] = "...",
					matcher = "Fuzzy",
					semanticTokens = false,
					staticcheck = true,
					symbolMatcher = "fuzzy",
					usePlaceholders = true,
				},
			},
		})

		vim.lsp.enable({
			"buf_ls",
			"htmx",
			"tailwindcss",
			"golangci_lint_ls",
			"typos_lsp",
			"lua_ls",
			"gopls",
			"marksman",
		})
	end,
}
