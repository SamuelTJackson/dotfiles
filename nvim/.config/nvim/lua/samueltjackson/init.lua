require("samueltjackson.set")
require("samueltjackson.remap")
require("samueltjackson.lazy_init")

local augroup = vim.api.nvim_create_augroup
local SamuelTJacksonGroup = augroup("SamuelTJackson", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
local tele = require("telescope.builtin")

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})
autocmd({ "BufWritePre" }, {
	group = SamuelTJacksonGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

local function organize_imports()
	vim.cmd("TSToolsAddMissingImports")
	vim.cmd("TSToolsOrganizeImports")
end

autocmd("LspAttach", {
	group = SamuelTJacksonGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		local filetype = vim.bo[e.buf].filetype

		vim.keymap.set("n", "gd", function()
			tele.lsp_definitions()
		end, opts)
		vim.keymap.set("n", "gi", function()
			tele.lsp_implementations()
		end, opts)
		vim.keymap.set("n", "gr", function()
			tele.lsp_references()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>ws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>sd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>nd", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "<leader>pd", function()
			vim.diagnostic.goto_prev()
		end, opts)

		if filetype == "typescriptreact" then
			vim.keymap.set("n", "<leader>i", organize_imports)
		end

		vim.keymap.set("n", "<leader>vr", function()
			vim.lsp.buf.rename()
		end, opts)
		-- Filetype-specific keymap
		if filetype == "go" then
			vim.keymap.set("n", "<leader>i", "<cmd>GoImportRun<CR>")
		end
	end,
})

autocmd("FocusGained", {
	callback = function()
		local closedBuffers = {}
		vim.iter(vim.api.nvim_list_bufs())
			:filter(function(bufnr)
				local valid = vim.api.nvim_buf_is_valid(bufnr)
				local loaded = vim.api.nvim_buf_is_loaded(bufnr)
				return valid and loaded
			end)
			:filter(function(bufnr)
				local bufPath = vim.api.nvim_buf_get_name(bufnr)
				local doesNotExist = vim.loop.fs_stat(bufPath) == nil
				local notSpecialBuffer = vim.bo[bufnr].buftype == ""
				local notNewBuffer = bufPath ~= ""
				return doesNotExist and notSpecialBuffer and notNewBuffer
			end)
			:each(function(bufnr)
				local bufName = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
				table.insert(closedBuffers, bufName)
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end)
	end,
})

-- Override tab width for JavaScript files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "javascript",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.rs",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = {
			only = { "quickfix" },
			diagnostics = vim.tbl_map(function(d)
				return d.user_data.lsp
			end, vim.diagnostic.get(0)),
			triggerKind = 1,
		}
		params.range = {
			start = { line = 0, character = 0 },
			["end"] = { line = #vim.api.nvim_buf_get_lines(0, 0, -1, false), character = 0 },
		}
		vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result, context, config)
			for _, action in ipairs(result or {}) do
				if action.title == "Remove all the unused imports" then
					local client = vim.lsp.get_client_by_id(context.client_id)
					client.request("codeAction/resolve", action, function(err_resolve, resolved_action)
						if err_resolve then
							vim.notify(err_resolve.code .. ": " .. err_resolve.message, vim.log.levels.ERROR)
							return
						end
						if resolved_action.edit then
							vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
						end
					end)
					return
				end
			end
		end)
	end,
})
