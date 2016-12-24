" Theme
  syntax enable
  let g:seoul256_background = 235
  let g:seoul256_light_background = 252
  colo seoul256

  " No need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
  " Turn on spelling for markdown files
  autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
  " Fighlight bad words in red
  autocmd BufRead,BufNewFile *.md hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224

  " Devicons
  let g:airline_powerline_fonts = 1
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_conceal_nerdtree_brackets = 1
  let g:webdevicons_enable_unite = 1
  let g:webdevicons_enable_airline_tabline = 1
  let g:webdevicons_enable_airline_statusline = 1
  let g:WebDevIconsOS = 'Darwin'
  let g:airline#extensions#tabline#buffer_idx_mode = 1

  " Airline
  let g:airline#extensions#tabline#enabled = 1
  set hidden
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='oceanicnext'
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
  nmap <leader>, :bnext<CR>
  nmap <leader>. :bprevious<CR>

  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  set encoding=utf8
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h13

