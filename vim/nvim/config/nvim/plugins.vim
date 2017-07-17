" Plugins

" If vundle is not installed, do it first
  if (!isdirectory(expand("$HOME/.vim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.vim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.vim/repos/github.com/Shougo/dein.vim"))
  endif

  set nocompatible

" Required:
    set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/

" Required:
  call dein#begin(expand('~/.vim'))
  let pluginsExist = 0

" Let NeoBundle manage NeoBundle
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')

" search
  call dein#add('Shougo/unite.vim')
  call dein#add('mileszs/ack.vim')
  call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
  call dein#add('junegunn/fzf.vim')
  call dein#add('easymotion/vim-easymotion')

" syntax
  call dein#add('stephpy/vim-yaml', {'on_ft': 'yaml'})
  call dein#add('elzr/vim-json', {'on_ft': 'json'})
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
  call dein#add('scrooloose/syntastic')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('alx741/vim-hindent', {'on_ft': 'haskell'})
  call dein#add('alfredodeza/pytest.vim')

" layout
  call dein#add('jreybert/vimagit')
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('sjl/gundo.vim')

" themes
  call dein#add('mhinz/vim-startify')
  call dein#add('vim-airline/vim-airline')
  call dein#add('mhartington/oceanic-next')
  call dein#add('junegunn/seoul256.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('jacoborus/tender.vim')

" git
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/vim-github-dashboard')
  call dein#add('mattn/gist-vim')
  call dein#add('rhysd/github-complete.vim')
  call dein#add('mhinz/vim-signify')

" completion
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('eagletmt/neco-ghc')

" edition
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('Chiel92/vim-autoformat')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('junegunn/vim-easy-align')

" utils
  call dein#add('tpope/vim-projectionist')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('AndrewRadev/switch.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
  call dein#add('ujihisa/neco-look')
  call dein#add('mhinz/vim-sayonara')
  call dein#add('mattn/webapi-vim')
  call dein#add('rhysd/nyaovim-popup-tooltip')
  call dein#add('kassio/neoterm')

" snippets
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  if dein#check_install()
    call dein#install()
  endif
  call dein#end()
" Required:
  filetype plugin indent on

" Plugin config
" FZF
" <C-x> <C-v> open file in horizontal and vertical split
" <C-t> open file in new tab
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
  \}

  let g:fzf_layout = { 'down': '~40%' }

  let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

  let g:fzf_colors = {
    \'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
  \}

  nnoremap <C-S-p> :BTags<cr>
  nnoremap <C-p> :FZF<cr>
  nnoremap <C-h> :History<cr>
  nnoremap <C-l> :Lines<cr>

  autocmd VimEnter * command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

" Silver searcher
" :ag
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    cnoreabbrev ag Ack
  endif
  nnoremap <C-f> :Ag<space>

" TagBar
" _
  nmap _ :TagbarOpenAutoClose<CR>

" Easy motion:
" <leader> f
  map  <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)

" NERDTree
" -
  nmap - :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  let g:NERDTreeWinSize=45
  let g:NERDTreeAutoDeleteBuffer=1
  let g:NERDTreeIgnore = ['\.pyc$', 'DS_Store']
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:NERDTreeMinimalUI=1
  let g:NERDTreeHijackNetrw=0

" Github dashboard:
" :GHDashboard :GHDashboard USER :GHActivity :GHActivity USER :GHActivity USER/REPO
  let g:github_dashboard = { 'username': 'paccorsi' }

" TComment:
" <c-/>
  vnoremap <c-/> :TComment<cr>

" Easy-align
" ga
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

" Multi cursor
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

" Syntactic
  let g:syntastic_python_checkers = ['pylint', 'flake8', 'python']
  let g:syntastic_python_checkers = ['pylint', 'python']
  let g:syntastic_python_pylint_args='--ignore=E501'

" Deoplete
  let g:deoplete#enable_at_startup = 1
  autocmd CompleteDone * pclose

" Jedi
  let g:jedi#auto_initialization = 0
  let g:jedi#completions_enabled = 0
  let g:jedi#goto_command = "<leader>d"

  let g:jedi#goto_assignments_command = "<leader>a"
  let g:jedi#goto_definitions_command = ""
  let g:jedi#usages_command = "<leader>n"
  let g:jedi#rename_command = "<leader>r"

" Neosnippet
" Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets, ~/Github/ionic-snippets, ~/.vim/bundle/angular-vim-snippets/snippets'

" SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"
