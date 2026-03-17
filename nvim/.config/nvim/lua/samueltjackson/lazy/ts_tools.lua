return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		filetypes = { -- ← override the bad defaults
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		settings = {
			separate_diagnostic_server = true,
			jsx_close_tag = {
				enable = true,
				filetypes = { "javascriptreact", "typescriptreact" },
			},
		},
	},
}
