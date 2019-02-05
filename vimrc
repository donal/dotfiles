
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-rails'


" these do indenting
" for Go:
" set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
" for acer:
" set softtabstop=4 shiftwidth=4 expandtab
" for me/rails:
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" for python:
" set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" for li3:
"set tabstop=4 shiftwidth=4

autocmd FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab

"set autoindent
"set smartindent
set list listchars=trail:_,tab:>.
"set list listchars=trail:_,tab:>-
"set nolist

autocmd FileType go setlocal nolist

" this is for spelling:
autocmd BufNewFile,BufRead *.txt,*.md,README set spell spelllang=en_gb

"set spell spelllang=en_gb
"autocmd BufNewFile,BufRead *.txt,README set spell spelllang=en_gb

set ignorecase
set smartcase
set incsearch
set ruler
set noerrorbells
set showmode
set showmatch
"**unset
set textwidth=79
set number
"set notextauto
"set notextmode
"set t_Co=8
"set t_Sf=^[[3%p1%dm
"set t_Sb=^[[4%p1%dm
"set ai
"set background=dark

"nopaste by default which means 
set nopaste

set tags=tags;/
let Tlist_WinWidth=60

" can't use supertab as tab is used for snippets
"set completeopt=longest,menuone
"source ~/.vim/scripts/supertab.vim
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "<C-P>"
"imap <C-O> <C-X><C-O>

"source ~/.vim/scripts/autotag.vim

" am i even using this? ->
"source ~/.vim/scripts/php-doc.vim
"for php-doc plugin
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>
vnoremap <buffer> <C-D> :call PhpDocRange()<CR> 
let g:pdv_cfg_Uses = 1

map <C-T>z :set tags=tags;/,~/.vim/tags/zf<CR>
map <C-T>h :set tags=tags;/,~/.vim/tags/habari<CR>

nmap P <Plug>ManPageView

"set ofu=syntaxcomplete#Complete
au FileType php set omnifunc=phpcomplete#CompletePHP

"colorscheme peachpuff
"colorscheme ir_black
syntax on
set background=dark
let g:solarized_termcolors=256
set t_Co=256
let g:solarized_termtrans = 1
colorscheme solarized
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.phtml set filetype=php

map ,d :NERDTreeToggle . <CR> " that's d for directory, not d for nerD
let Tlist_GainFocus_On_ToggleOpen = 1
map ,t :TlistToggle <CR>
let g:NERDTreeQuitOnOpen = 1

function Tabbing(type)
  let type=a:type
  if type == "acer"
    set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  elseif type == "go"
    set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
  elseif type == "mine"
    set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  endif
endfunction

map ,h :call Tabbing("habari")<CR>
map ,g :call Tabbing("go")<CR>
map ,a :call Tabbing("acer")<CR>
map ,m :call Tabbing("mine")<CR>

function ToggleLineNumbering()
  if &number
    set nonumber
  else
    set number
  endif
endfunction

function ToggleTrail()
  if &list
    set nolist
  else
    set list listchars=trail:_,tab:>.
  endif
endfunction

function ToggleTextWidth()
  if &l:textwidth > 0
    set textwidth=0
    echo "textwidth is disabled"
  else
    set textwidth=79
    echo "textwidth is 79"
  endif
endfunction

let b:spelling_lang = "en_gb"
function ToggleSpellChecking()
  if &spell
    setlocal nospell
    echo "spell check turned off"
  else
    setlocal spell! spelllang=en_gb
    echo "spell check for " . b:spelling_lang . " on"
  endif
endfunction

map ,b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <silent> ,n :call ToggleLineNumbering()<CR>
map <silent> ,l :call ToggleTrail()<CR>
map <silent> ,w :call ToggleTextWidth()<CR>
map <silent> ,s :call ToggleSpellChecking()<CR>
vnoremap <Leader>c :s!^!// !<cr>gv:s!^// // !!<cr>

"function OpenPHPManual(keyword)
"  let web = 'lynx -accept_all_cookies --cookie_file=/home/jon/.lynx_cookies --cookie_save_file=/home/jon/.lynx_cookies --cookies'
"  let url = 'http://jp2.php.net/' . a:keyword
"  exec '!' . web . ' "' . url . '"'
"endfunction

"function OpenPHPManualLocal(keyword)
"  let web = 'links'
"  let url = 'http://localhost/dev/php/doc/function.' . a:keyword . '.html'
"  exec '!' . web . ' "' . url . '"'
"endfunction

"noremap ,p :call OpenPHPManualLocal(expand('<cword>'))<CR>
"noremap fj :call OpenPHPManual(expand('<cword>'))<CR>


" preview window... to get it to open vert right, or horiz as desired
function PreviewTag(top)
  "by MW
  set previewheight=25
  exe "silent! pclose"
  if &previewwindow " don't do this in the preview window
    return
  endif
  let w = expand("<cword>") " get the word under cursor
  exe "ptjump " . w
  " if any non False arg, open in simple horiz window so simply return
  if a:top
    return
  endif
  " otherwise, make it vertical
  exe "silent! wincmd P"
  if &previewwindow " if we really get there...
    if has("folding")
      silent! .foldopen " don't want a closed fold
    endif
    wincmd L " move preview window to the left
    " wincmd p " back to caller
    if !&previewwindow " got back
      wincmd _
      " make caller full size (I use minibufexplorer and for some reason
      " the window is altered by the preview window split and manipulation
      " so wincmd _ sets it back... your mileage may vary
    endif
  endif
endfunction

" right hand window full height preview window
inoremap <C-]> <Esc>:call PreviewTag(0)<CR>
nnoremap <C-]> :call PreviewTag(0)<CR>
" simple "above the caller" preview window,
"nnoremap <M-]> :call PreviewTag(1)<CR>
"inoremap <M-]> <Esc>:call PreviewTag(1)<CR>
" close preview
"noremap <C-]>[ <Esc>:pc<CR>

nmap <C-V>u :VCSUpdate<CR>
nmap <C-V>s :VCSStatus<CR>
nmap <C-V>c :VCSCommit<CR>
nmap <C-V>d :VCSDiff<CR>
nmap <C-V>v :VCSVimDiff<CR>

map <C-S-p> :set paste!<Bar>set paste?<CR>

" what does this do??"
"filetype plugin indent on
filetype on
filetype plugin on
"augroup myfiletypes
"  autocmd!
"  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
"augroup END
if has("autocmd")
  filetype plugin indent on
endif

"Gist:
"set g:github_user=donal
"set g:github_token=4022cfd6358378aa51f3d953af94cad6

" set path+=/Users/donal/dev/rails/depot/**
" set path+=/Users/donal/dev/rails/depot/lib/**
" set suffixesadd=.rb
" set includeexpr+=substitute(v:fname,'s$','','g')
" or you can add substitution pattern s/ies$/y/g, s/ves$/f/g likethis:
" setincludeexpr+=substitute(substitute(substitute(v:fname,'s$','','g'),'ie$','y','g'),'ve$','f','g')


