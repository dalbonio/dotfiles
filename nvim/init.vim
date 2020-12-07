
call plug#begin('~/.config/nvim/plugged')


"colorscheme
Plug 'dracula/vim'

"To easier comment files
Plug 'tpope/vim-commentary'
"Vim Git Integration
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
"Linting async"
Plug 'dense-analysis/ale'
"God grep plugin"
Plug 'junegunn/fzf'
"Nerdtree simpler"
Plug 'tpope/vim-vinegar'
"Interact with repl in tmux
Plug 'jpalardy/vim-slime'
"Vim with tmux
Plug 'christoomey/vim-tmux-navigator'


call plug#end()

filetype plugin indent on
syntax on

"airline theme"
let g:airline_theme='deus'

"setting leader to comma"
let mapleader = ","

set relativenumber
"setting tab to occupy only 2 spaces
set tabstop=2 shiftwidth=2 expandtab

"map ,e to open fzf file finder"
nmap <leader>e :FZF<CR>
nnoremap <silent> <leader><space> :noh <CR>

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{last}"}


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
