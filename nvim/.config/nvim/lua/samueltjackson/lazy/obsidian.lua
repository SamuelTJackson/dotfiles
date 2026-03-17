return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open note" },
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
		{ "<leader>ot", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New note from template" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
		{ "<leader>od", "<cmd>ObsidianDelete<CR>", desc = "Delete note" },
		{ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "Switch workspace" },
	},
	opts = {
		completion = {
			blink = true,
		},
		ui = {
			enable = false,
		},
		workspaces = {
			{
				name = "personal",
				path = "~/notes/personal",
			},
			{
				name = "work",
				path = "~/notes/work",
			},
		},
	},
}
