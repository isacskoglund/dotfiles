require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "pyright" },
})

local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	ensure_installed = {
		"cspell", -- spelling

		-- Lua
		"stylua",

		-- Golang
		"golangci_lint", -- lint
		"golines", -- fix long lines
		"goimports", -- automatic imports
		"goimports-reviser", -- group imports
		"gomodifytags", -- tags
		"delve", -- debugger

		-- Python
		"black",
		"pylint",

		-- Javascript
		"prettier",
		"eslint_d",
	},
})
