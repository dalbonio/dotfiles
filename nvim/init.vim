execute pathogen#infect()
syntax on
filetype plugin indent on

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
