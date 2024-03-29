vim9script

# save fzf history in $VIMPATH
g:fzf_history_dir = $VIMPATH .. '/.fzf-history'

# jump to the existing window if possible
g:fzf_buffers_jump = 1

# default to using large, centered popup window
g:fzf_layout = { window: { width: 1,
                           height: 0.88,
                           xoffset: 0.5,
                           yoffset: 0.5,
                           highlight: 'NonText',
                           border: 'sharp' } }

# preview files using highlight
g:fzf_files_options = printf('--preview "%s {} | head -%d"',
  $VIMPATH .. '/pack/packager/opt/fzf.vim/bin/preview.sh', &lines)

# paint pleasant monotone statusline in fzf buffer
# fixes disappearing statusline in main vim window
def FzfStatusLine(): void
  highlight fzf1 ctermbg=95
  setlocal statusline=%#fzf1#%{'\ '}
enddef

augroup fzfstatusline
  autocmd!
  autocmd User FzfStatusLine FzfStatusLine()
augroup END

def LoadFzf(): void
  packadd fzf
  packadd fzf.vim
enddef

# facilitate lazy loading
augroup loadfzf
  autocmd!
  autocmd User LoadFzf ++once LoadFzf()
augroup END

def FzfWordCompletion(): string
  silent doautocmd User LoadFzf
  var dictionaries = empty(&dictionary) ? "/usr/share/dict/words" : join(split(&dictionary, ","), " ")
  return fzf#vim#complete(fzf#wrap({ source: printf('cat %s', dictionaries),
                                     window: { width: 0.2,
                                               height: 0.9,
                                               xoffset: 1,
                                               highlight: 'NonText',
                                               border: 'sharp' } }))
enddef

# word completion using cat
inoremap <expr> <C-X><C-K> FzfWordCompletion()

def FzfPathCompletion(): string
  silent doautocmd User LoadFzf
  return fzf#vim#complete(fzf#wrap({ source: 'fd --hidden',
                                     window: { width: 0.9,
                                               height: 0.35,
                                               yoffset: 0.9,
                                               highlight: 'NonText',
                                               border: 'sharp' } }))
enddef

# path completion using fd
inoremap <expr> <C-X><C-F> FzfPathCompletion()

def FzfLineCompletion(): string
  silent doautocmd User LoadFzf
  return fzf#vim#complete(fzf#wrap({ source: 'rg -n ^ --color=always',
                                     options: '--ansi --delimiter : --nth 3..',
                                     prefix: '^.*$',
                                     reducer: (lines) => join(split(lines[0], ':\zs')[2 : ], '') }))
enddef

# global line completion using rg (not just open buffers)
inoremap <expr> <C-X><C-L> FzfLineCompletion()

# |:Rg| hidden files with global ignore config and preview window
command! -bang -nargs=* Rg fzf#vim#grep(join([
  \ 'rg',
  \ '--column',
  \ '--line-number',
  \ '--no-heading',
  \ '--color=always',
  \ '--smart-case',
  \ '--hidden',
  \ '--ignore-file $HOME/.config/search/ignore',
  \ '--',
  \ shellescape(<q-args>)
  \ ], ' '),
  \ 1,
  \ fzf#vim#with_preview({ options: ['--info=inline'] }, 'down:60%'),
  \ <bang>0
  \ )

# lazy loaded commands from junegunn/fzf.vim/plugin/fzf.vim
command!      -bang -nargs=? -complete=dir FZFFiles       :silent doautocmd User LoadFzf | Files<bang> <args>
command!      -bang -nargs=? FZFGitFiles                  :silent doautocmd User LoadFzf | GitFiles<bang> <args>
command!      -bang -nargs=? FZFGFiles                    :silent doautocmd User LoadFzf | GFiles<bang> <args>
command! -bar -bang -nargs=? -complete=buffer FZFBuffers  :silent doautocmd User LoadFzf | Buffers<bang> <args>
command!      -bang -nargs=* FZFLines                     :silent doautocmd User LoadFzf | Lines<bang> <args>
command!      -bang -nargs=* FZFBLines                    :silent doautocmd User LoadFzf | BLines<bang> <args>
command! -bar -bang FZFColors                             :silent doautocmd User LoadFzf | Colors<bang>
command!      -bang -nargs=+ -complete=dir FZFLocate      :silent doautocmd User LoadFzf | Locate<bang> <args>
command!      -bang -nargs=* FZFAg                        :silent doautocmd User LoadFzf | Ag<bang> <args>
command!      -bang -nargs=* FZFRg                        :silent doautocmd User LoadFzf | Rg<bang> <args>
command!      -bang -nargs=* FZFTags                      :silent doautocmd User LoadFzf | Tags<bang> <args>
command!      -bang -nargs=* FZFBTags                     :silent doautocmd User LoadFzf | BTags<bang> <args>
command! -bar -bang FZFSnippets                           :silent doautocmd User LoadFzf | Snippets<bang>
command! -bar -bang FZFCommands                           :silent doautocmd User LoadFzf | Commands<bang>
command! -bar -bang FZFMarks                              :silent doautocmd User LoadFzf | Marks<bang>
command! -bar -bang FZFHelptags                           :silent doautocmd User LoadFzf | Helptags<bang>
command! -bar -bang FZFWindows                            :silent doautocmd User LoadFzf | Windows<bang>
command! -bar -bang FZFCommits                            :silent doautocmd User LoadFzf | Commits<bang>
command! -bar -bang FZFBCommits                           :silent doautocmd User LoadFzf | BCommits<bang>
command! -bar -bang FZFMaps                               :silent doautocmd User LoadFzf | Maps<bang>
command! -bar -bang FZFFiletypes                          :silent doautocmd User LoadFzf | Filetypes<bang>
command!      -bang -nargs=* FZFHistory                   :silent doautocmd User LoadFzf | History<bang> <args>

# search with rg from cwd
nnoremap <silent> <leader>/ :FZFRg<CR>

# search prefixed by word under cursor with rg from cwd
nnoremap <silent> <leader>f :let @z = expand('<cword>')<CR>:FZFRg <C-R>z<CR>
xnoremap <silent> <leader>f "zy:FZFRg <C-R>z<CR>

# open files from cwd
nnoremap <silent> <leader>o :FZFFiles<CR>

# select window
nnoremap <silent> <leader>O :FZFWindows<CR>

# select buffer
nnoremap <silent> <leader>lz :FZFBuffers<CR>

# search lines in current buffer
nnoremap <silent> <M-f> :FZFBLines<CR>

# search lines in loaded buffers
nnoremap <silent> <M-F> :FZFLines<CR>

# search marks
nnoremap <silent> <M-m> :FZFMarks<CR>

# select color scheme
nnoremap <silent> <leader>lc :FZFColors<CR>

# vim: set filetype=vim foldmethod=marker foldlevel=0 nowrap:
