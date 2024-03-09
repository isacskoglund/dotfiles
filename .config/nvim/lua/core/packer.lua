-- Automatic installation
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
	end
end

ensure_packer()

-- Install plugins
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- colorscheme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- highlighting
	use("nvim-treesitter/nvim-treesitter")

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- file explorer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- comments
	use("numToStr/Comment.nvim")

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-path",
	})

	-- manage lsp servers, linters and formatters
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})

	-- configure lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("onsails/lspkind.nvim")

	-- formatting & linting
	use("nvimtools/none-ls.nvim")
	use("jay-babu/mason-null-ls.nvim")

	-- debugging
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("leoluz/nvim-dap-go")
	use("mfussenegger/nvim-dap-python")

	-- git
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")

	--tmux
	use("christoomey/vim-tmux-navigator")
end)
