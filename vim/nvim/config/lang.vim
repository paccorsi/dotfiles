" Languages

" Python {{{
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%120v.*/
  autocmd FileType python set nowrap

nnoremap <leader>e :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! s:PlaceholderImgTag(size)
  let url = 'http://dummyimage.com/' . a:size . '/000000/555555'
  let [width,height] = split(a:size, 'x')
  execute "normal a<img src=\"".url."\" width=\"".width."\" height=\"".height."\" />"
  endfunction
command! -nargs=1 PlaceholderImgTag call s:PlaceholderImgTag(<f-args>)
" }}}"

" Haskell {{{
  au FileType haskell setlocal omnifunc=necoghc#omnifunc
  au FileType haskell onoremap <silent> ia :<c-u>silent execute "normal! ?->\r:nohlsearch\rwvf-ge"<CR>
  au FileType haskell onoremap <silent> aa :<c-u>silent execute "normal! ?->\r:nohlsearch\rhvEf-ge"<CR>
  
  function! JumpHaskellFunction(reverse)
    call search('\C[[:alnum:]]*\s*::', a:reverse ? 'bW' : 'W')
  endfunction

  au FileType haskell nnoremap <buffer><silent> ]] :call JumpHaskellFunction(0)<CR>
  au FileType haskell nnoremap <buffer><silent> [[ :call JumpHaskellFunction(1)<CR>
  au FileType haskell nnoremap <buffer> gI gg /\cimport<CR><ESC>:noh<CR>
  au FileType haskell nnoremap <buffer> gC :e *.cabal<CR>

  let g:hindent_on_save = 1
  let g:hindent_line_length = 80
  let g:hindent_indent_size = 4
  au FileType haskell nmap <silent><buffer> g<space> vii<ESC>:silent!'<,'> EasyAlign /->/<CR>

  au FileType haskell inoreab <buffer> int Int
  au FileType haskell inoreab <buffer> integer Integer
  au FileType haskell inoreab <buffer> string String
  au FileType haskell inoreab <buffer> double Double
  au FileType haskell inoreab <buffer> float Float
  au FileType haskell inoreab <buffer> true True
  au FileType haskell inoreab <buffer> false False
  au FileType haskell inoreab <buffer> maybe Maybe
  au FileType haskell inoreab <buffer> just Just
  au FileType haskell inoreab <buffer> nothing Nothing
  au FileType haskell inoreab <buffer> io IO ()
" }}}

