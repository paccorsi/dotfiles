" System Settings
  set spelllang=en_us
  set cb=unnamedplus
  set splitright
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set termguicolors
  set noshowmode
  set noswapfile
  filetype on
  set relativenumber number
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0

" Font settings
  set encoding=utf8
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11

" Hide abandoned buffers
  set hid

" block select not limited by shortest line
  set virtualedit=
  set wildmenu
  set laststatus=2
  set wrap linebreak nolist
  set wildmode=full

  nnoremap ; :
  let mapleader = ','
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files
  autocmd BufRead * normal zz
  let g:jsx_ext_required = 0
  set complete=.,w,b,u,t,k
  let g:gitgutter_max_signs = 1000  " default value
  
  " Reload when entering the buffer or gaining focus
  au FocusGained,BufEnter * :silent! !
  " Save when exiting the buffer or losing focus
  au FocusLost,WinLeave * :silent! w

  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'
  let g:table_mode_corner="|"

" Make searching better
  set gdefault      " Never have to type /g at the end of search / replace again
  set ignorecase    " case insensitive searching (unless specified)
  set smartcase
  set hlsearch
  nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
  set incsearch
  set showmatch

"Allow usage of mouse in iTerm
  set ttyfast
  set mouse=
  set visualbell
  set cursorline

" Tab completion
  set wildmenu
  set wildmode=full
  set wildignorecase
  set wildchar=<Tab>

  let g:python_host_prog = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'

" Folding
function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd FileType vim setlocal fdc=1
set foldlevel=99
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

autocmd FileType html setlocal fdl=99
autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType javascript,typescript,css,scss,json setlocal foldmethod=marker
autocmd FileType javascript,typescript,css,scss,json setlocal foldmarker={,}
autocmd FileType coffee setl foldmethod=indent

source ~/.config/nvim/keys.vim
source ~/.config/nvim/lang.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/theme.vim
source ~/.config/nvim/unite.vim

