local formatters = {
	lua = { "stylua" },
	go = { "golines", "goimports" },
	terraform = { "terraform_fmt" },
	["terraform-vars"] = { "terraform_fmt" },
	tf = { "terraform_fmt" },
	hcl = { "terragrunt_hclfmt" },
	sql = { "sqlfmt" },
	json = { "jq" },
	templ = { "templ", "injected" },
	sh = { "shfmt" },

	-- ["*"] = { "codespell" },
}
local prettier_ft = {
	"css",
	"html",
	"javascriptreact",
	"javascript",
	"less",
	"scss",
	"typescript",
	"typescriptreact",
	"vue",
	"json",
}

for _, filetype in pairs(prettier_ft) do
	formatters[filetype] = { "prettierd", "biome-check" }
end

return {
	"stevearc/conform.nvim",
	opts = {
		ignore_errors = true,
		formatters_by_ft = formatters,
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_fallback = true,
		},
		formatters = {
			golines = {
				args = { "-m", 140, "--base-formatter", "gofumpt" },
			},
			biome = {
				require_cwd = true,
			},
			biome_check = {
				require_cwd = true,
			},
			prettierd = {
				require_cwd = true,
			},
			prettier = {
				require_cwd = true,
			},
		},
	},
}
