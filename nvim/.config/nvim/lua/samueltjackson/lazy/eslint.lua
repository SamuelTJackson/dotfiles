return {
	{
		"esmuellert/nvim-eslint",
		config = function()
			require("nvim-eslint").setup({
				root_dir = function(bufnr)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					return vim.fs.root(fname, {
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.json",
						"eslint.config.js",
						"eslint.config.ts",
						"eslint.config.mjs",
					}) or vim.fs.root(fname, { ".git" })
				end,
			})
		end,
	},
}
