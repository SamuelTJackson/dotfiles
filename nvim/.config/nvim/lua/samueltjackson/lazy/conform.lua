local function in_biome_project(bufnr)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	local root = vim.fs.dirname(fname)
	local biome_files = vim.fs.find({
		"biome.json",
		"biome.jsonc",
		".biomerc",
		".biomerc.json",
	}, { upward = true, path = root })
	return #biome_files > 0
end

local function in_prettier_project(bufnr)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	local root = vim.fs.dirname(fname)
	local prettier_files = vim.fs.find({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	}, { upward = true, path = root })
	return #prettier_files > 0
end

local formatters = {
	lua = { "stylua" },
	go = { "golines", "goimports" },
	terraform = { "terraform_fmt" },
	["terraform-vars"] = { "terraform_fmt" },
	tf = { "terraform_fmt" },
	hcl = { "terragrunt_hclfmt" },
	sql = { "sqlfmt" },

	templ = { "templ", "injected" },
	sh = { "shfmt" },
	javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	json = { "biome-check", "prettierd", "prettier", "jq", stop_after_first = true },
	jsonc = { "biome-check", "prettierd", "prettier", "jq", stop_after_first = true },
	css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	less = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	vue = { "biome-check", "prettierd", "prettier", stop_after_first = true },
	scss = { "biome-check", "prettierd", "prettier", stop_after_first = true },

	-- ["*"] = { "codespell" },
}

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
			["biome-check"] = {
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
