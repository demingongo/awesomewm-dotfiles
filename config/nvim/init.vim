call plug#begin()

" https://github.com/catppuccin/nvim
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" https://github.com/nvim-treesitter/nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" https://github.com/nvim-tree/nvim-tree.lua
Plug 'nvim-tree/nvim-web-devicons' " icons
Plug 'nvim-tree/nvim-tree.lua'

" https://github.com/romgrk/barbar.nvim
Plug 'romgrk/barbar.nvim'

" https://github.com/feline-nvim/feline.nvim
Plug 'feline-nvim/feline.nvim'

" https://github.com/lewis6991/gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim'

" https://github.com/samodostal/image.nvim
Plug 'samodostal/image.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'm00qek/baleia.nvim', { 'tag': 'v1.2.0' } " color support

" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

call plug#end()

" Load setup
source $HOME/.config/nvim/setup.vim
