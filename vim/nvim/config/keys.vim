" Delete word
  nnoremap = daw
  nnoremap <S-\> daw

" No macros
  nnoremap Q <nop>
  map q <Nop>

" Delete line 
  inoremap <c-d> <esc>ddi

" Navigate between panes
  nmap <silent> <c-up> :wincmd k<CR>
  nmap <silent> <c-down> :wincmd j<CR>
  nmap <silent> <c-left> :wincmd h<CR>
  nmap <silent> <c-right> :wincmd l<CR>

" Use numbers to pick the tab you want (like iTerm)
  nmap <silent> <C-1> :tabn 1<cr>
  nmap <silent> <C-2> :tabn 2<cr>
  nnoremap <C-3> :tabn 3<cr>
  nnoremap <C-4> :tabn 4<cr>
  nnoremap <C-5> :tabn 5<cr>
  nnoremap <C-6> :tabn 6<cr>
  nnoremap <C-7> :tabn 7<cr>
  nnoremap <C-8> :tabn 8<cr>
  nnoremap <C-9> :tabn 9<cr>

" Navigate between display lines
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> k gk
  noremap  <silent> j gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>

" Copy current files path to clipboard
  nmap cp :let @+ = expand("%") <cr>

  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k
  nnoremap ; :
  inoremap <c-f> <c-x><c-f>

" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  vnoremap y "*y<CR>
  nnoremap Y "*Y<CR>


" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  nnoremap <leader>d "_d
  vnoremap <leader>d "_d

