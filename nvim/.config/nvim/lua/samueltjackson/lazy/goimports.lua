return {
	{
		"mattn/vim-goimports",
		ft = { "go" },
		config = function()
			-- enable auto format when write (default)
			vim.g.goimports = 0
			-- disable simplify filter
			vim.g.goimports_simplify = 1
		end,
	},
}
