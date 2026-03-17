return {
	"mason-org/mason.nvim",
	config = function()
		require("mason").setup()

		local registry = require("mason-registry")

		local tools = {
			"tailwindcss-language-server",
			"biome",
			"codelldb",
			"eslint_d",
			"jq",
			"prettierd",
			"stylua",
			"typescript-language-server",
		}

		registry.refresh(function()
			for _, tool in ipairs(tools) do
				local pkg = registry.get_package(tool)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
}
