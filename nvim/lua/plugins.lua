
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local has_vscode = vim.g.vscode == 1
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Simple plugins can be specified as strings
	use 'tpope/vim-surround'
	use 'terrortylor/nvim-comment'
	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', disable = has_vscode }
	use 'unblevable/quick-scope'

	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	  disable = has_vscode
	}

	use {'kyazdani42/nvim-web-devicons', disable = has_vscode}
	use { "lukas-reineke/indent-blankline.nvim", disable = has_vscode }
	use { 'windwp/nvim-autopairs', disable = has_vscode }
	use { 'neovim/nvim-lspconfig' , disable = has_vscode}
	use { 'hrsh7th/nvim-cmp' , disable = has_vscode}
	use { 'hrsh7th/cmp-nvim-lsp' , disable = has_vscode}
	use { 'hrsh7th/cmp-buffer' , disable = has_vscode}
	use { 'hrsh7th/cmp-path' , disable = has_vscode}
	use { 'hrsh7th/cmp-cmdline' , disable = has_vscode}
	use { 'saadparwaiz1/cmp_luasnip' , disable = has_vscode}
	use { 'L3MON4D3/LuaSnip' , disable = has_vscode}
	use { 'rafamadriz/friendly-snippets' , disable = has_vscode}
	use { 'ray-x/lsp_signature.nvim' , disable = has_vscode}
	-- use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp', disable= has_vscode}
	use { 'onsails/lspkind-nvim' , disable = has_vscode}
	use { 'nvim-treesitter/nvim-treesitter' , disable = has_vscode}
	use { 'folke/tokyonight.nvim' , disable = has_vscode}
	use { 'Yazeed1s/oh-lucy.nvim' , disable = has_vscode}

	use { 'herringtondarkholme/yats.vim' , disable = has_vscode}

	use { 'leafgarland/typescript-vim' , disable = has_vscode}
	use { 'peitalin/vim-jsx-typescript' , disable = has_vscode}

	use { 'RRethy/nvim-base16' , disable = has_vscode}

	use { 'lambdalisue/fern.vim' , disable = has_vscode}

	use { "catppuccin/nvim", as = "catppuccin", disable = has_vscode }

	use { 'ibhagwan/fzf-lua',
	  -- optional for icon support
	  requires = { 'kyazdani42/nvim-web-devicons' }
	}

	use { 'voldikss/vim-floaterm' , disable = has_vscode}

	use { 'mhartington/formatter.nvim', disable = has_vscode }

	use {
	  'romgrk/barbar.nvim',
	  requires = {'kyazdani42/nvim-web-devicons'},
	  disable = has_vscode
	}

	use { 'tpope/vim-fugitive', disable = has_vscode}

end)

