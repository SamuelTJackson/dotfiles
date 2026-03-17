return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1001,
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
				},
			},
		},
	},
}
