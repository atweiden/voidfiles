vim9script

# facilitate lazy loading
augroup lazylanguages
  autocmd!
  autocmd User LoadElixir ++once packadd vim-elixir
  autocmd User LoadFennel ++once packadd vim-fennel
  autocmd User LoadFinn ++once packadd vim-finn
  autocmd User LoadFsharp ++once packadd vim-fsharp
  autocmd User LoadGo ++once packadd vim-go
  autocmd User LoadHare ++once packadd hare.vim
  autocmd User LoadJanet ++once packadd janet.vim
  autocmd User LoadJournal ++once packadd vim-journal
  autocmd User LoadJust ++once packadd vim-just
  autocmd User LoadKiwi ++once packadd vim-kiwi
  autocmd User LoadRaku ++once packadd vim-raku
  autocmd User LoadRust ++once packadd rust.vim
  autocmd User LoadToml ++once packadd vim-toml
  autocmd User LoadTypst ++once packadd typst.vim
  autocmd User LoadZig ++once packadd zig.vim
augroup END

augroup languages
  autocmd!

  # elixir
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadElixir',
      join([
        '*.ex',
        '*.exs',
        'mix.lock',
        '*.eex',
        '*.heex',
        '*.leex',
        '*.sface',
        '*.lexs'
      ], ','))
  autocmd FileType elixir silent doautocmd User LoadElixir
  autocmd FileType eelixir silent doautocmd User LoadElixir

  # enc
  autocmd BufNewFile,BufRead *.enc setlocal filetype=enc

  # fennel
  autocmd BufReadPre,FileReadPre *.fnl,*.kiwi silent doautocmd User LoadFennel
  autocmd FileType fennel silent doautocmd User LoadFennel

  # finn
  autocmd BufReadPre,FileReadPre *.finn silent doautocmd User LoadFinn
  autocmd FileType finn silent doautocmd User LoadFinn

  # fsharp
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadFsharp',
      join([
        '*.fs',
        '*.fsx',
        '*.fsi'
      ], ','))
  autocmd FileType fsharp silent doautocmd User LoadFsharp

  # git
  autocmd BufReadPre,FileReadPre COMMIT_EDITMSG b:noreturntopos = 1

  # go
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadGo',
      join([
        '*.go',
        '*.s',
        '*.tmpl',
        'go.mod',
        'go.sum',
        'go.work.sum',
        'go.work'
      ], ','))
  autocmd FileType asm silent doautocmd User LoadGo
  autocmd FileType go silent doautocmd User LoadGo
  autocmd FileType gohtmltmpl silent doautocmd User LoadGo
  autocmd FileType gomod silent doautocmd User LoadGo
  autocmd FileType gosum silent doautocmd User LoadGo
  autocmd FileType gowork silent doautocmd User LoadGo

  # gpg
  autocmd QuitPre *.gpg silent! system('pkill gpg-agent')

  # hare
  autocmd BufReadPre,FileReadPre *.ha silent doautocmd User LoadHare
  autocmd FileType hare silent doautocmd User LoadHare

  # hugo
  autocmd BufNewFile,BufRead **/layouts/**.html setlocal filetype=gohtmltmpl

  # janet
  autocmd BufReadPre,FileReadPre *.janet,*.jdn silent doautocmd User LoadJanet
  autocmd FileType janet silent doautocmd User LoadJanet

  # journal
  autocmd FileType journal silent doautocmd User LoadJournal

  # just
  autocmd BufReadPre,FileReadPre \c{,*.}just{,file} silent doautocmd User LoadJust
  autocmd FileType just silent doautocmd User LoadJust

  # kiwi
  autocmd BufReadPre,FileReadPre *.kiwi silent doautocmd User LoadKiwi
  autocmd FileType kiwi silent doautocmd User LoadKiwi

  # raku
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadRaku',
      join([
        '*.raku',
        '*.rakumod',
        '*.rakudoc',
        '*.rakutest',
        '*.pm6',
        '*.p6',
        '*.pl6',
        '*.t6',
        '*.t',
        '*.nqp'
      ], ','))
  autocmd FileType raku silent doautocmd User LoadRaku

  # rust
  autocmd BufReadPre,FileReadPre *.rs silent doautocmd User LoadRust
  autocmd FileType rust silent doautocmd User LoadRust

  # toml
  execute printf('autocmd BufReadPre,FileReadPre %s silent doautocmd User LoadToml',
      join([
        '*.toml',
        'pdm.lock',
        'Gopkg.lock',
        'Cargo.lock'
      ], ','))
  autocmd FileType toml silent doautocmd User LoadToml

  # txn
  autocmd BufNewFile,BufRead *.txn setlocal filetype=txn

  # typst
  autocmd BufReadPre,FileReadPre *.typ silent doautocmd User LoadTypst
  autocmd FileType typst silent doautocmd User LoadTypst

  # xbps
  autocmd BufReadCmd *.xbps tar#Browse(expand("<amatch>"))

  # zig
  autocmd BufReadPre,FileReadPre *.zig,*.zon silent doautocmd User LoadZig
  autocmd FileType zig silent doautocmd User LoadZig
augroup END

# vim: set filetype=vim foldmethod=marker foldlevel=0 nowrap:
