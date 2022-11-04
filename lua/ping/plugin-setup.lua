-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "plugin-setup.lua" },
	command = "source <afile> | PackerSync",
	group = vim.api.nvim_create_augroup("ping", { clear = true }),
})

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("arcticicestudio/nord-vim") -- preferred colorscheme

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("ping.plugins.comment")
		end,
	})

	-- file explorer
	use({
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("ping.plugins.nvim-tree")
		end,
	})

	-- vs-code like icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("ping.plugins.lualine")
		end,
	})

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			require("ping.plugins.telescope")
		end,
	}) -- fuzzy finder

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("ping.plugins.nvim-cmp")
		end,
	}) -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("ping.plugins.luasnip")
		end,
	}) -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use({
		"williamboman/mason.nvim",
		config = function()
			require("ping.plugins.lsp.mason")
		end,
	}) -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("ping.plugins.lsp.lspconfig")
		end,
	}) -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("ping.plugins.lsp.lspsaga")
		end,
	}) -- enhanced lsp uis
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("ping.plugins.lsp.null-ls")
		end,
	}) -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("ping.plugins.treesitter")
		end,
	})

	-- auto closing
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("ping.plugins.autopairs")
		end,
	}) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	}) -- show line modifications on left hand side
	use("kdheepak/lazygit.nvim") -- lazygit integration

	-- speed up startup time
	use("lewis6991/impatient.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
