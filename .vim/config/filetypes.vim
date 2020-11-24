" facilitate lazy loading
augroup lazylanguages
  autocmd!
  autocmd User LoadElixir ++once packadd vim-elixir
  autocmd User LoadFennel ++once packadd vim-fennel
  autocmd User LoadFinn ++once packadd vim-finn
  autocmd User LoadJanet ++once packadd janet.vim
  autocmd User LoadJournal ++once packadd vim-journal
  autocmd User LoadConjure ++once packadd conjure
  autocmd User LoadSexp ++once packadd vim-sexp
  autocmd User LoadRaku ++once packadd vim-raku
  autocmd User LoadToml ++once packadd vim-toml
  autocmd User LoadZig ++once packadd zig.vim
augroup END

augroup languages
  autocmd!

  " elixir
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadElixir',
      \ join([
      \   '*.ex',
      \   '*.exs',
      \   'mix.lock',
      \   '*.eex',
      \   '*.leex'
      \ ], ','))
  autocmd FileType elixir silent doautocmd User LoadElixir

  " enc
  autocmd BufNewFile,BufRead *.enc setlocal filetype=enc

  " fennel
  autocmd BufReadPre,FileReadPre *.fnl silent doautocmd User LoadFennel
  autocmd FileType fennel silent doautocmd User LoadFennel

  " finn
  autocmd BufReadPre,FileReadPre *.finn silent doautocmd User LoadFinn
  autocmd FileType finn silent doautocmd User LoadFinn

  " git
  autocmd BufReadPre,FileReadPre COMMIT_EDITMSG let b:noreturntopos = 1

  " gpg
  autocmd QuitPre *.gpg silent! call system('pkill gpg-agent')

  " janet
  autocmd BufReadPre,FileReadPre *.janet silent doautocmd User LoadJanet
  autocmd FileType janet silent doautocmd User LoadJanet

  " journal
  autocmd FileType journal silent doautocmd User LoadJournal

  " raku
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadRaku',
      \ join([
      \   '*.raku',
      \   '*.rakumod',
      \   '*.rakudoc',
      \   '*.rakutest',
      \   '*.pm6',
      \   '*.p6',
      \   '*.pl6',
      \   '*.t6',
      \   '*.t',
      \   '*.nqp'
      \ ], ','))
  autocmd FileType raku silent doautocmd User LoadRaku

  " toml
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadToml',
      \ join([
      \   '*.toml',
      \   'Gopkg.lock',
      \   'Cargo.lock'
      \ ], ','))
  autocmd FileType toml silent doautocmd User LoadToml

  " txn
  autocmd BufNewFile,BufRead *.txn setlocal filetype=txn

  " xbps
  autocmd BufReadCmd *.xbps call tar#Browse(expand("<amatch>"))

  " zig
  autocmd BufReadPre,FileReadPre *.zig,*.zir silent doautocmd User LoadZig
  autocmd FileType zig silent doautocmd User LoadZig
  autocmd FileType zir silent doautocmd User LoadZig
augroup END

" vim: set filetype=vim foldmethod=marker foldlevel=0 nowrap:
