""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Options

set encoding=utf-8
set background=dark
set ruler
set backspace=indent,eol,start
set nohlsearch noincsearch
set mouse=
set nofoldenable
set hidden
set history=1000
set wildmenu wildmode=list:longest
set shortmess=aoOtTI
set undofile undodir=~/.vim/bak,.
if has("cryptv")
  set cryptmethod=blowfish
end
set nomodeline " security
set t_Co=256 " use all 256 colours

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Mappings

let mapleader = ','

" Abbreviations
iabbrev <expr> isodate strftime('%Y-%m-%d')
iabbrev <expr> isotime strftime('%Y-%m-%dT%H:%M:%S%z')

" Command mode
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-D> <Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Advanced features

" When editing a file, always jump to the last cursor position
augroup cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") ># 0 && line("'\"") <=# line('$') |
        \   exe "normal! g'\"" |
        \ endif
augroup END

" SudoWrite
" Source: https://github.com/tpope/vim-eunuch
command! -bar SudoWrite :
      \ setlocal nomodified |
      \ silent exe 'write !sudo tee % >/dev/null' |
      \ let &modified = v:shell_error
cabbrev <silent> w!! SudoWrite

" Crosshairs
augroup crosshairs
  autocmd!
  autocmd BufReadPre *
        \ if &t_Co ==# 256 |
        \   highlight CursorLine   cterm=NONE ctermbg=237 |
        \   highlight CursorColumn cterm=NONE ctermbg=237 |
        \ else |
        \   highlight CursorLine   cterm=NONE ctermbg=Gray |
        \   highlight CursorColumn cterm=NONE ctermbg=Gray |
        \ endif
augroup END
nnoremap <silent> <Leader>l :set cursorline! cursorcolumn!<CR>

" ExtraneousWhitespace
nnoremap <silent> <Leader>w :call ExtraneousWhitespace()<CR>
highlight ExtraneousWhitespace NONE
match ExtraneousWhitespace /\s\+$\| \+\ze\t/

function! ExtraneousWhitespace()
  if exists('g:extraneouswhitespace') && g:extraneouswhitespace
    highlight ExtraneousWhitespace NONE
    let g:extraneouswhitespace = 0
  else
    highlight ExtraneousWhitespace ctermbg=DarkRed
    let g:extraneouswhitespace = 1
  endif
endfunction

" Unlimited inteprocess paste buffer
nnoremap <silent> <Leader>y :.!tee ~/.vimipc<CR>
vnoremap <silent> <Leader>y :!tee ~/.vimipc<CR>
nnoremap <silent> <Leader>d :.!> ~/.vimipc<CR>
vnoremap <silent> <Leader>d :!> ~/.vimipc<CR>
nnoremap <silent> <Leader>p :r ~/.vimipc<CR>
nnoremap <silent> <Leader>P :-1r ~/.vimipc<CR>

" Blame
nnoremap <silent> <Leader>B :echo system('git blame -L'.line('.').',+1 '.expand('%'))<CR>
" Yank from HEAD (aka per-line checkout from HEAD)
nnoremap <silent> <Leader>Y :exe 'norm! 0C'.system('git blame -pL'.line('.').',+1 HEAD '.expand('%').'<Bar>tail -n1 <Bar>cut -c2-<Bar>tr -d "\n"')<CR>0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntax, indenting, etc.

" Indenting
set autoindent nocindent smarttab
set shiftwidth=2 softtabstop=2 expandtab

" Syntax
syntax on
filetype plugin indent on

" Python
augroup python
  autocmd!
  autocmd FileType python setl shiftwidth=4 softtabstop=4
  autocmd FileType python syntax match Error "\t"
augroup END

" JavaScript
augroup javascript
  autocmd!
  autocmd FileType javascript setl shiftwidth=4 softtabstop=4
augroup END

" PHP
augroup php
  " This doesn't work, see .vim/after/ftplugin/php.vim
  " autocmd!
  " autocmd FileType php setl commentstring=//\ %s
augroup END

" Go
augroup go
  autocmd!
  autocmd BufRead,BufNewFile *.go setl filetype=go
  autocmd FileType go setl shiftwidth=8 softtabstop=8 noexpandtab
  " This doesn't work, see .vim/after/ftplugin/go.vim
  " autocmd FileType go setl commentstring=//\ %s
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Encryption

augroup encryption
  autocmd!
  autocmd BufReadPre *
        \ if system('head -c 9 ' . expand('<afile>')) ==# 'VimCrypt~' |
        \   setlocal noswapfile nobackup nowritebackup viminfo= |
        \ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Imports

" % also works on if/endif etc
runtime macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins

" Commentary
xmap <Leader>c <Plug>Commentary
nmap <Leader>c <Plug>CommentaryLine

" Rainbow Parentheses
augroup rainbow_parentheses
  autocmd!
  " Highlights (), [], and {}
  autocmd VimEnter *
        \ if exists(':RainbowParenthesesToggle') |
        \   execute 'RainbowParenthesesLoadSquare' |
        \   execute 'RainbowParenthesesLoadBraces' |
        \   execute 'nnoremap <silent> <Leader>r :RainbowParenthesesToggle<CR>' |
        \ endif
augroup END

" vim-go - don't complain when editing files as root
let g:go_disable_autoinstall = 1
" vim-go - run goimports automatically
let g:go_fmt_command = "goimports"

" disable syntastic for Go - we use vim-go
let g:syntastic_disabled_filetypes=['go']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" .vimrc.local

if filereadable(expand($MYVIMRC.'.local'))
  source $MYVIMRC.local
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Unbundle

runtime bundle/vim-unbundle/unbundle.vim
