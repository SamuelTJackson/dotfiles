return {
	"saghen/blink.cmp",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		"mikavilpas/blink-ripgrep.nvim",
	},
	version = "1.*",
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "super-tab",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<C-k>"] = { "select_prev", "fallback_to_mappings" },
			["<C-j>"] = { "select_next", "fallback_to_mappings" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
		completion = {
			menu = {
				border = "single",
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
				},
			},
			documentation = {
				window = {
					border = "single",
				},
				auto_show = true,
			},
		},
		signature = { window = { border = "single" } },
		cmdline = { enabled = true },
		sources = {
			default = { "lsp", "snippets", "path" },
		},
	},
}
