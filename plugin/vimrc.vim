set nocompatible

let g:nuth_path = fnamemodify(resolve(expand("<sfile>:p")),":h:h")

" statusline {{{
" Fugitive git statusline
set statusline=%{fugitive#statusline()}\ 
" Filename etc.
set statusline+=%f%m%r%h%w
" char code
set statusline+=%=[%B]\ 
" line/totallines:column
set statusline+=[%l/%L:%v]\ 
" encoding
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]\ 
" filetype
set statusline+=%y\ 
" file format
set statusline+=[%{&ff}]
" }}}
" encoding {{{

let &termencoding=&encoding
let &fileencoding=&encoding
setglobal encoding=utf-8

" }}}
" spelling {{{

set spelllang=en
set spellsuggest=9

" }}}
" formatting {{{

set textwidth=80 formatoptions+=t
set expandtab
set shiftwidth=4 tabstop=4 
set cindent autoindent smartindent

" }}}
" mapping {{{

let g:mapleader = " "
let g:maplocalleader = " "

set pastetoggle=<F12>
" reindent code
nmap <F11> 1G=G
" toggle line numbers
map <F8> :set number!<CR><Bar>:echo "line numbers: " . strpart("OffOn", 3 * &number, 3) <CR>
nmap <F6> :NERDTreeToggle<CR>
" jump to next compiler issue
nmap <F2> :cnext<CR>

" toggle spell check
map <Leader>s :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" tabbing like ff/chrome/irssi
map t :tabnew<CR>
map w :tabclose<CR>

for i in range(1, 9)
    execute "map " . i . " :tabn " . i . "<CR>"
    execute "map <M-" . i . "> :tabn " . i . "<CR>"
endfor

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" }}}
" misc {{{

set backspace=indent,eol,start
set visualbell
set showcmd
set mouse=a
set ruler
set history=50
set laststatus=2
set wildignore+=*.aux,*.log,*.nav,*.out,*.snm,*.toc,*.bbl,*.blg,*.pdf,*.dvi,*.ps,*.o,*.pyc,*.class,*.fasl,*.exe,*.so
" set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" make scrolling happen before cursor
" hits last line of text to see a bit
" more surrounding text
set scrolloff=4

" set xterm title and icon-title (see statusline for expandos)
set title

" }}}
" filetypes {{{

" needed to run the ftplugins
let g:tex_flavor='latex'

" }}}
" enable menu {{{

source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=< 
set wcm=<C-Z>
map <F4> :emenu <C-Z>

" }}}
" plugins {{{
" plugin custom settings {{{

let g:localvimrc_ask = 0
let s:C_LocalTemplateFile     = $HOME.'/.vim-addon/cvim/c-support/templates/Templates'

" }}}
" indent plugins and syntax {{{

filetype indent plugin on | syn on

" }}}

" }}}
" autocmd {{{

" readonly files
au BufRead *.o,*.so,*.log set readonly

" skeletons {{{

au BufNewFile *.* call Skeleton()

fun! Skeleton()

    let skel = g:nuth_path . "/skeleton/skel." . expand("%:e")

    if filereadable(skel)
        execute '0r ' . skel
    endif

endfunc

" }}}

" }}}

" vim: set foldmethod=marker :
