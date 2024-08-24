local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(current_client, bufnr)
	if current_client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(client)
						--  only use null-ls for formatting instead of lsp server
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end,
		})
	end
end

null_ls.setup({
	sources = {
		-- diagnostics["cspell"], -- needs proper configuration

		-- lua
		formatting["stylua"],

		-- golang
		diagnostics["golangci_lint"],
		formatting["goimports"],
		formatting["goimports_reviser"],
		code_actions["gomodifytags"],

		-- python
		formatting["black"],
		diagnostics["pylint"],

		-- javascipt
		formatting["prettier"],
		diagnostics["eslint_d"],
	},
	on_attach = on_attach,
})
