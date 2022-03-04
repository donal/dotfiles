
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-rails'

" these do indenting
" for rails:
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

autocmd FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd FileType js setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd FileType c setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
autocmd FileType rust setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab


"TODO make this toggle-able:
" set list listchars=trail:_,tab:>.,eol:¬
set list listchars=trail:_,tab:>-
"set nolist

autocmd FileType go setlocal nolist
autocmd FileType cpp setlocal nolist
autocmd FileType js setlocal nolist
" autocmd FileType c setlocal nolist
" autocmd FileType c setlocal list listchars=trail:_,tab:>.,eol:¬
autocmd FileType c setlocal list listchars=trail:_,tab:>.
autocmd FileType rust setlocal nolist

" this is for spelling:
"set spell spelllang=en_gb
autocmd BufNewFile,BufRead *.txt,*.md,README set spell spelllang=en_gb

set ignorecase
set smartcase
set incsearch
set ruler
set noerrorbells
set showmode
set showmatch
"**unset
" set textwidth=79
" off by default:
set textwidth=0
set number
"set notextauto
"set notextmode
"set t_Co=8
"set t_Sf=^[[3%p1%dm
"set t_Sb=^[[4%p1%dm
"set ai
"set background=dark

"nopaste by default
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

syntax on

set background=dark
set t_Co=256
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox

map ,d :NERDTreeToggle . <CR> " that's d for directory, not d for nerD
let Tlist_GainFocus_On_ToggleOpen = 1
map ,t :TlistToggle <CR>
let g:NERDTreeQuitOnOpen = 1

function Tabbing(type)
  let type=a:type
  if type == "go"
    set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
  elseif type == "rails"
    set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  endif
endfunction

map ,g :call Tabbing("go")<CR>
map ,m :call Tabbing("rails")<CR>

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
    " set list listchars=trail:_,tab:>.,eol:¬
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

map <C-S-p> :set paste!<Bar>set paste?<CR>

filetype on
filetype plugin on
if has("autocmd")
  filetype plugin indent on
endif

set statusline+=%#warningmsg#
set statusline+=%*

