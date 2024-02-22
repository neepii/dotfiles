vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
	--the packer itself
	use 'wbthomason/packer.nvim'

	--cool stuff
	use 'junegunn/fzf.vim'
	use 'junegunn/fzf'
	use 'jiangmiao/auto-pairs'
	use 'christoomey/vim-tmux-navigator'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'williamboman/mason-lspconfig.nvim'
	use 'preservim/nerdtree'

	--pretty stuff
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'zacanger/angr.vim'

	--hrsh7th stuff
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
end)



require('lsp') -- lua/lsp.lua
require('cmd') -- lua/cmd.lua
