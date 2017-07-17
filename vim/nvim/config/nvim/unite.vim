" Unite
  let g:unite_split_rule = "botright"
  let g:unite_force_overwrite_statusline = 0
  let g:unite_source_rec_max_cache_files = 0

  function! s:unite_settings()
    let b:SuperTabDisabled = 1
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
    nmap <buffer> <ESC> <Plug>(unite_exit)
  endfunction

  autocmd FileType unite call s:unite_settings()

  let g:unite_source_menu_menus = {} " Useful when building interfaces at appropriate places

" IDE {{{
  let g:unite_source_menu_menus.ide = {
    \ 'description' : 'Refactor'
    \}

  let g:unite_source_menu_menus.ide.command_candidates = [
    \[' reformat code', 'Autoformat'],
    \[' check syntax', 'SyntasticCheck'],
    \[' strip whitespace', '%s/\s\+$//e'],
    \[' convert tabs to space', 'retab'],
    \[' redo', 'call jedi#rename()'],
    \[' undo', 'GundoShow'],
    \[' goto assignment', 'call jedi#goto_assignments()'],
    \[' goto definitions', 'call jedi#goto_definitions()'],
    \[' usages', 'call jedi#usages()'],
    \[' rename', 'call jedi#rename()']
  \]

  nnoremap <silent> <Leader>r :Unite -silent -buffer-name=ide -start-insert menu:ide<CR>
" }}}

" Git {{{
  let g:unite_source_menu_menus.git = {
    \ 'description' : 'Fugitive interface',
    \}

  let g:unite_source_menu_menus.git.command_candidates = [
    \[' all commits', 'Commits'],
    \[' git dashboard', 'GHDashboard'],
    \[' git activity', 'GHActivity'],
    \[' git blame', 'Gblame'],
    \[' git status', 'Gstatus'],
    \[' git diff', 'Gvdiff'],
    \[' git private gist', 'Gist -p'],
    \[' git commit', 'Gcommit'],
    \[' git stage/add', 'Gwrite'],
    \[' git checkout', 'Gread'],
    \[' git rm', 'Gremove'],
    \[' git cd', 'Gcd'],
    \[' git push', 'exe "Git! push " input("remote/branch: ")'],
    \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
    \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
    \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
    \[' git fetch', 'Gfetch'],
    \[' git merge', 'Gmerge'],
    \[' git browse', 'Gbrowse'],
    \[' git head', 'Gedit HEAD^'],
    \[' git parent', 'edit %:h'],
    \[' git log commit buffers', 'Glog --'],
    \[' git log current file', 'Glog -- %'],
    \[' git log last n commits', 'exe "Glog -" input("num: ")'],
    \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
    \[' git log until date', 'exe "Glog --until=" input("day: ")'],
    \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
    \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
    \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
    \[' git mv', 'exe "Gmove " input("destination: ")'],
    \[' git grep',  'exe "Ggrep " input("string: ")'],
    \[' git prompt', 'exe "Git! " input("command: ")'],
    \] " Append ' --' after log to get commit info commit buffers

  nnoremap <silent> <Leader>g :Unite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>
"}}}
