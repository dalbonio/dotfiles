execute pathogen#infect()
syntax on
filetype plugin indent on

:let mapleader = ","


function! MyGrep()
	let currentline = getline(".")
	let sparr = split(currentline)
	call map(sparr, {idx, val -> substitute(val, '<.*>', '.*', '')})
	let sentence = join(sparr[1:])
	execute 'vimgrep /@'.sparr[0].'(\"'.sentence.'\")/'.' **/*.java'
endfunction


nnoremap <leader><C-d> :call MyGrep()<CR>

