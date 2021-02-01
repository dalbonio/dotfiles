set nocompatible

filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')

" Neovim Lsp Plugins
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'tjdevries/lsp_extensions.nvim'

"Linting async"
" Plug 'dense-analysis/ale'

"Neovim Tree Sitter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
" Plug '/home/mpaulson/personal/contextprint.nvim'

" telescope requirements...
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Debugger Plugins
" Plug 'puremourning/vimspector'
" Plug 'szw/vim-maximizer'

" Use vim on man command
Plug 'vim-utils/vim-man'

" Plug 'ocaml/vim-ocaml'
" Plug 'jordwalke/vim-reasonml'

" Colorscheme
Plug 'dracula/vim'
Plug 'ghifarit53/tokyonight-vim'
" To easier comment files
Plug 'tpope/vim-commentary'
" Vim Git Integration
Plug 'tpope/vim-fugitive'
"Vim bottom bar
Plug 'vim-airline/vim-airline'
"Vim bottom bar themes
Plug 'vim-airline/vim-airline-themes'
"Vim git plugin to show diffs in the sign column
Plug 'airblade/vim-gitgutter'
"Vim blamer plugin
Plug 'APZelos/blamer.nvim'
"Neovim language server installer to autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Julia support
Plug 'JuliaEditorSupport/julia-vim'
"Surround elements easier like quoting something or putting parenthesis" 
Plug 'tpope/vim-surround'
"God grep plugin"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
"Nerdtree simpler"
Plug 'tpope/vim-vinegar'
"Interact with repl in tmux
Plug 'jpalardy/vim-slime'
"Vim with tmux
Plug 'christoomey/vim-tmux-navigator'
"Vim Polyglot
Plug 'sheerun/vim-polyglot'
"Ruby Support
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
"End of plug calls
call plug#end()

set termguicolors
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
colorscheme tokyonight

:set rtp+=<SHARE_DIR>/merlin/vim

"airline theme"
let g:airline_theme='deus'

"setting leader to comma"
let mapleader = ","

"setting tab to occupy only 2 spaces
set tabstop=2 shiftwidth=2 expandtab

set number

"map ,e to open fzf file finder"
nmap <leader>e :FZF<CR>
nnoremap <silent> <leader><space> :noh <CR>

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{last}"}


" lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }


let g:latex_to_unicode_file_types = '$^'
let g:latex_to_unicode_file_types_blacklist = '.*'


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" let g:ale_sign_error                  = '✘'
" let g:ale_sign_warning                = '⚠'
" highlight ALEErrorSign ctermbg        =NONE ctermfg=red
" highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
" let g:ale_linters_explicit            = 1
" let g:ale_lint_on_text_changed        = 'never'
" let g:ale_lint_on_enter               = 0
" let g:ale_lint_on_save                = 1
" let g:ale_fix_on_save                 = 1


