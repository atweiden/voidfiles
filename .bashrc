# ==============================================================================
# base {{{

# configure pinentry to use the correct tty
GPG_TTY="$(tty)"
export GPG_TTY

# if not running interactively, don't do anything
[[ $- != *i* ]] \
  && return

# end base }}}
# ==============================================================================
# bash settings {{{

# --- editor {{{

set -o vi
export EDITOR='vim'
export FCEDIT='vim'
export VISUAL='vim'
export SUDO_EDITOR='rvim'

# --- end editor }}}
# --- history {{{

export HISTCONTROL='ignoreboth'
export HISTIGNORE='l:ls:cd:exit'
export HISTSIZE=
export HISTFILESIZE=

# --- end history }}}
# --- less {{{

export LESS='-MRSXi#16j.5'
#             ||||||  |
#             ||||||  +-- center on search matches
#             |||||+----- scroll horizontally 16 columns at a time
#             ||||+------ case-insensitive search unless pattern contains uppercase
#             |||+------- don't clear the screen after exiting
#             ||+-------- don't wrap long lines
#             |+--------- parse color codes
#             +---------- show more information in prompt

# colors
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[00;47;30m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# disable less history file
export LESSHISTFILE=-

# --- end less }}}
# --- locale {{{

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# --- end locale }}}
# --- man pages {{{

# colorize/paginate man pages with less
export GROFF_NO_SGR=1
export MANPAGER="less $LESS"

# --- end man pages }}}
# --- opener {{{

export OPENER='vim'

# --- end opener }}}
# --- safety {{{

# do not overwrite existing file by redirect `>`
# use `>|` to override this setting
set -o noclobber

# --- end safety }}}
# --- shopt {{{

# check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS
shopt -s checkwinsize

# save multi-line commands in history as single line
shopt -s cmdhist

# enable recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# add failed commands to the bash history
shopt -s histreedit

# edit a recalled history line before executing
shopt -s histverify

# enable case-insensitive globbing, used in pathname expansion
shopt -s nocaseglob

# don't attempt completion if cmdline empty
shopt -s no_empty_cmd_completion

# --- end shopt }}}
# --- tmpdir {{{

[[ -z "$TMPDIR" ]] \
  && export TMPDIR='/tmp'

# --- end tmpdir }}}
# --- xdg {{{

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# --- end xdg }}}

# end bash settings }}}
# ==============================================================================
# terminal settings {{{

# --- display {{{

if [[ "$TERM" == 'linux' ]]; then
  export TERM='linux-16color'
fi

# miromiro dircolors by jwr
[[ -f "$HOME/.config/dircolors" ]] \
  && eval $(dircolors -b "$HOME/.config/dircolors")

# seoul256 console colors
echo -e "
\e]P0121212
\e]P1d68787
\e]P25f865f
\e]P3d8af5f
\e]P485add4
\e]P5d7afaf
\e]P687afaf
\e]P7d0d0d0
\e]P8626262
\e]P9d75f87
\e]PA87af87
\e]PBffd787
\e]PCadd4fb
\e]PDffafaf
\e]PE87d7d7
\e]PFe4e4e4
"
# get rid of artifacts
clear

# --- end display }}}
# --- remove ctrl-s ctrl-q {{{

# remove the ^S ^Q mappings. See all mappings: stty -a
stty -ixoff -ixon
stty stop undef
stty start undef

# --- end remove ctrl-s ctrl-q }}}

# end terminal settings }}}
# ==============================================================================
# path {{{

unset PATH

# --- defaults {{{

PATH='/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin'

# --- end defaults }}}
# --- dotfiles {{{

PATH="$HOME/.bin:$PATH"

# --- end dotfiles }}}
# --- raku {{{

PATH="$HOME/.raku/bin:$PATH"
PATH="/usr/lib/raku/core/bin:$PATH"
PATH="/usr/lib/raku/site/bin:$PATH"
PATH="/usr/lib/raku/vendor/bin:$PATH"

# --- end raku }}}
# --- rust {{{

PATH="$HOME/.cargo/bin:$PATH"

# --- end rust }}}

export PATH

# end path }}}
# ==============================================================================
# presence {{{

_has_ack="$(command -v ack)"
_has_ag="$(command -v ag)"
_has_colordiff="$(command -v colordiff)"
_has_curl="$(command -v curl)"
_has_diffr="$(command -v diffr)"
_has_fd="$(command -v fd)"
_has_gdb="$(command -v gdb)"
_has_git="$(command -v git)"
_has_icdiff="$(command -v icdiff)"
_has_iex="$(command -v iex)"
_has_irb="$(command -v irb)"
_has_irssi="$(command -v irssi)"
_has_locate="$(command -v locate)"
_has_lynx="$(command -v lynx)"
_has_mosh="$(command -v mosh)"
_has_ncdu="$(command -v ncdu)"
_has_nvim="$(command -v nvim)"
_has_rclone="$(command -v rclone)"
_has_rg="$(command -v rg)"
_has_sqlite3="$(command -v sqlite3)"
_has_tree="$(command -v tree)"
_has_units="$(command -v units)"
_has_vim="$(command -v vim)"
_has_wget="$(command -v wget)"

# end presence }}}
# ==============================================================================
# prompt {{{

# --- history {{{

export PROMPT_COMMAND='history -a; history -c; history -r'

# --- end history }}}
# --- ps1 {{{

unset PS1
PS1+="\[\e[01;31m\]"
PS1+="┌─[\[\e[01;35m\u\e[01;31m\]]"
PS1+="──[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;32m\]]:\w$\[\e[01;31m\]\n\[\e[01;31m\]"
PS1+="└──\[\e[01;36m\]>>\[\e[0m\]"
export PS1

# --- end ps1 }}}

# end prompt }}}
# ==============================================================================
# aliases {{{

# --- bash {{{

alias incognito=' unset HISTFILE'
alias ,='clear'

# --- end bash }}}
# --- curl {{{

[[ -n "$_has_curl" ]] \
  && alias curl='curl --config $HOME/.config/curl/curlrc'

# --- end curl }}}
# --- dbs {{{

if [[ -n "$_has_sqlite3" ]]; then
  alias sqlite3='sqlite3 -init $HOME/.config/sqlite3/sqliterc'
  alias sql='sqlite3 -interactive :memory:'
fi

# --- end dbs }}}
# --- diff {{{

if [[ -n "$_has_icdiff" ]]; then
  alias diff='icdiff'
elif [[ -n "$_has_colordiff" ]]; then
  alias diff='colordiff'
fi

# --- end diff }}}
# --- directory navigation {{{

alias ls='ls \
  --classify \
  --color=auto \
  --group-directories-first \
  --time-style=long-iso'
alias l='ls -1'
alias l1='ls -1A'
alias la='ls -a'
alias ll='ls -laih'
[[ -n "$_has_tree" ]] \
  && alias tree='tree -FC --charset ascii --dirsfirst'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias cdd='cd $HOME/Downloads'
alias cdp='cd $HOME/Projects'
alias cds='cd $HOME/.src'
alias :q='exit'

# --- end directory navigation }}}
# --- disk space {{{

alias df='df --si'
alias du='du --si --max-depth=1'
alias dusort='du --block-size=M --max-depth=0 --one-file-system --total * \
  | sort --numeric-sort --reverse'
[[ -n "$_has_ncdu" ]] \
  && alias ncdu='ncdu \
    --color dark \
    -rr \
    -x \
    --si \
    --confirm-quit \
    --exclude-from $HOME/.config/search/ignore'

# --- end disk space }}}
# --- elixir {{{

[[ -n "$_has_iex" ]] \
  && alias iex='iex --dot-iex $HOME/.config/elixir/iex.exs'

# --- end elixir }}}
# --- file compression {{{

alias zip='zip -9'
alias gzip='gzip -9'
alias bzip2='bzip2 -9'

# --- end file compression }}}
# --- gdb {{{

[[ -n "$_has_gdb" ]] \
  && alias gdb='gdb -q -nh -x $HOME/.config/gdb/init'

# --- end gdb }}}
# --- git {{{

if [[ -n "$_has_git" ]]; then
  alias g='git'
  alias gc='git commit'
  alias gca='git commit --all'
  alias gcaf='git commit --all --file=$HOME/s.ci'
  alias gcp='git commit --patch'
  alias gd='git diff'
  alias gdr='git diffrev "$@"'
  alias gdrh='git diffrev HEAD'
  alias gpl='git pull'
  alias gps='git push'
  alias gs='git status --short --branch'
fi

# --- end git }}}
# --- grepping {{{

alias grep='grep --ignore-case --color=auto'
alias fgrep='fgrep --ignore-case --color=auto'
alias egrep='egrep --ignore-case --color=auto'
alias history\?='history | grep -v -E "grep|history\?" | grep "$@"'
alias ls\?='ls -1F | grep "$@"'
alias ps\?='ps -a -x -f | grep -v grep | grep "$@"'
alias pkg\?='xbps-query --search "$@"'
alias sysctl\?='sysctl --all 2>/dev/null | grep -v grep | grep "$@"'
[[ -n "$_has_ack" ]] \
  && alias ack='ack \
      --ackrc=$HOME/.config/ack/ackrc'
[[ -n "$_has_ag" ]] \
  && alias ag='ag \
      --hidden \
      --smart-case \
      --path-to-ignore $HOME/.config/search/ignore'
if [[ -n "$_has_rg" ]]; then
  alias rg='rg \
    --hidden \
    --ignore-file $HOME/.config/search/ignore \
    --smart-case'
  alias rgu='rg \
    --no-ignore \
    --no-ignore-files \
    --unrestricted \
    --unrestricted \
    --unrestricted'
fi
[[ -n "$_has_locate" ]] \
  && alias locate='locate --ignore-case'

# --- end grepping }}}
# --- info {{{

alias info='info --vi-keys'

# --- end info }}}
# --- irssi {{{

[[ -n "$_has_irssi" ]] \
  && alias irssi='irssi \
    --config=$HOME/.config/irssi/config \
    --home=$HOME/.config/irssi'

# --- end irssi }}}
# --- lynx {{{

[[ -n "$_has_lynx" ]] \
  && alias lynx='lynx -cfg $HOME/.config/lynx/lynx.cfg'

# --- end lynx }}}
# --- path {{{

alias path='echo -e ${PATH//:/\\n}'

# --- end path }}}
# --- processes {{{

alias ps='ps --forest'

# --- end processes }}}
# --- rclone {{{

[[ -n "$_has_rclone" ]] \
  && alias rclone='rclone \
    --transfers=16 \
    --checkers=32 \
    --ignore-size \
    --low-level-retries=7 \
    --retries=25 \
    --delete-after'

# --- end rclone }}}
# --- repl {{{

alias r='repl'
alias rex='repl --language elixir -- --dot-iex $HOME/.config/elixir/iex.exs'
alias rnl='repl --language fennel'

# --- end repl }}}
# --- ruby {{{

[[ -n "$_has_irb" ]] \
  && alias irb='irb \
    --colorize \
    --multiline \
    --readline'

# --- end ruby }}}
# --- safety {{{

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# --- end safety }}}
# --- ssh {{{

[[ -n "$_has_mosh" ]] \
  && alias mosh='mosh -a'

# --- end ssh }}}
# --- stopwatch {{{

alias timer='echo "Timer started. Stop with Ctrl-D." \
  && date \
  && time cat \
  && date'

# --- end stopwatch }}}
# --- text {{{

alias hr='printf "$(printf "\e["$(shuf -i 91-97 -n 1)";1m%%%ds\e[0m\n" "$(tput cols)")" \
  | tr " " ='

# --- end text }}}
# --- timestamp {{{

alias dt='date --iso-8601=s'
alias dt-adelaide='_t=$(TZ=Australia/Adelaide dt)     ; echo "[$_t] Adelaide"'
alias dt-amsterdam='_t=$(TZ=Europe/Amsterdam dt)      ; echo "[$_t] Amsterdam"'
alias dt-anchorage='_t=$(TZ=America/Anchorage dt)     ; echo "[$_t] Anchorage"'
alias dt-andorra='_t=$(TZ=Europe/Andorra dt)          ; echo "[$_t] Andorra"'
alias dt-anguilla='_t=$(TZ=America/Anguilla dt)       ; echo "[$_t] Anguilla"'
alias dt-antigua='_t=$(TZ=America/Antigua dt)         ; echo "[$_t] Antigua"'
alias dt-auckland='_t=$(TZ=Pacific/Auckland dt)       ; echo "[$_t] Auckland"'
alias dt-barcelona='_t=$(TZ=Europe/Barcelona dt)      ; echo "[$_t] Barcelona"'
alias dt-belize='_t=$(TZ=America/Belize dt)           ; echo "[$_t] Belize"'
alias dt-berlin='_t=$(TZ=Europe/Berlin dt)            ; echo "[$_t] Berlin"'
alias dt-bermuda='_t=$(TZ=Atlantic/Bermuda dt)        ; echo "[$_t] Bermuda"'
alias dt-bogota='_t=$(TZ=America/Bogota dt)           ; echo "[$_t] Bogotá"'
alias dt-brisbane='_t=$(TZ=Australia/Brisbane dt)     ; echo "[$_t] Brisbane"'
alias dt-bucharest='_t=$(TZ=Europe/Bucharest dt)      ; echo "[$_t] Bucharest"'
alias dt-budapest='_t=$(TZ=Europe/Budapest dt)        ; echo "[$_t] Budapest"'
alias dt-buenosaires='_t=$(TZ=America/Buenos_Aires dt); echo "[$_t] Buenos Aires"'
alias dt-calcutta='_t=$(TZ=Asia/Calcutta dt)          ; echo "[$_t] Calcutta"'
alias dt-cayman='_t=$(TZ=America/Cayman dt)           ; echo "[$_t] Cayman"'
alias dt-chicago='_t=$(TZ=America/Chicago dt)         ; echo "[$_t] Chicago"'
alias dt-costarica='_t=$(TZ=America/Costa_Rica dt)    ; echo "[$_t] Costa Rica"'
alias dt-darwin='_t=$(TZ=Australia/Darwin dt)         ; echo "[$_t] Darwin"'
alias dt-dublin='_t=$(TZ=Europe/Dublin dt)            ; echo "[$_t] Dublin"'
alias dt-efate='_t=$(TZ=Pacific/Efate dt)             ; echo "[$_t] Efate"'
alias dt-fiji='_t=$(TZ=Pacific/Fiji dt)               ; echo "[$_t] Fiji"'
alias dt-galapagos='_t=$(TZ=Pacific/Galapagos dt)     ; echo "[$_t] Galapagos"'
alias dt-gibraltar='_t=$(TZ=Europe/Gibraltar dt)      ; echo "[$_t] Gibraltar"'
alias dt-grenada='_t=$(TZ=America/Grenada dt)         ; echo "[$_t] Grenada"'
alias dt-guam='_t=$(TZ=Pacific/Guam dt)               ; echo "[$_t] Guam"'
alias dt-guatemala='_t=$(TZ=America/Guatemala dt)     ; echo "[$_t] Guatemala"'
alias dt-helsinki='_t=$(TZ=Europe/Helsinki dt)        ; echo "[$_t] Helsinki"'
alias dt-hobart='_t=$(TZ=Australia/Hobart dt)         ; echo "[$_t] Hobart"'
alias dt-hongkong='_t=$(TZ=Asia/Hong_Kong dt)         ; echo "[$_t] Hong Kong"'
alias dt-honolulu='_t=$(TZ=Pacific/Honolulu dt)       ; echo "[$_t] Honolulu"'
alias dt-isleofman='_t=$(TZ=Europe/Isle_of_Man dt)    ; echo "[$_t] Isle of Man"'
alias dt-istanbul='_t=$(TZ=Europe/Istanbul dt)        ; echo "[$_t] Istanbul"'
alias dt-jamaica='_t=$(TZ=America/Jamaica dt)         ; echo "[$_t] Jamaica"'
alias dt-jerusalem='_t=$(TZ=Asia/Jerusalem dt)        ; echo "[$_t] Jerusalem"'
alias dt-johannesburg='_t=$(TZ=Africa/Johannesburg dt); echo "[$_t] Johannesburg"'
alias dt-juneau='_t=$(TZ=America/Juneau dt)           ; echo "[$_t] Juneau"'
alias dt-kiev='_t=$(TZ=Europe/Kiev dt)                ; echo "[$_t] Kiev"'
alias dt-lisbon='_t=$(TZ=Europe/Lisbon dt)            ; echo "[$_t] Lisbon"'
alias dt-london='_t=$(TZ=Europe/London dt)            ; echo "[$_t] London"'
alias dt-losangeles='_t=$(TZ=America/Los_Angeles dt)  ; echo "[$_t] Los Angeles"'
alias dt-malta='_t=$(TZ=Europe/Malta dt)              ; echo "[$_t] Malta"'
alias dt-managua='_t=$(TZ=America/Managua dt)         ; echo "[$_t] Managua"'
alias dt-melbourne='_t=$(TZ=Australia/Melbourne dt)   ; echo "[$_t] Melbourne"'
alias dt-monaco='_t=$(TZ=Europe/Monaco dt)            ; echo "[$_t] Monaco"'
alias dt-montevideo='_t=$(TZ=America/Montevideo dt)   ; echo "[$_t] Montevideo"'
alias dt-montreal='_t=$(TZ=America/Montreal dt)       ; echo "[$_t] Montréal"'
alias dt-moscow='_t=$(TZ=Europe/Moscow dt)            ; echo "[$_t] Moscow"'
alias dt-nauru='_t=$(TZ=Pacific/Nauru dt)             ; echo "[$_t] Nauru"'
alias dt-newyork='_t=$(TZ=America/New_York dt)        ; echo "[$_t] New York"'
alias dt-niue='_t=$(TZ=Pacific/Niue dt)               ; echo "[$_t] Niue"'
alias dt-novosibirsk='_t=$(TZ=Asia/Novosibirsk dt)    ; echo "[$_t] Novosibirsk"'
alias dt-oslo='_t=$(TZ=Europe/Oslo dt)                ; echo "[$_t] Oslo"'
alias dt-palau='_t=$(TZ=Pacific/Palau dt)             ; echo "[$_t] Palau"'
alias dt-panama='_t=$(TZ=America/Panama dt)           ; echo "[$_t] Panama"'
alias dt-paris='_t=$(TZ=Europe/Paris dt)              ; echo "[$_t] Paris"'
alias dt-perth='_t=$(TZ=Australia/Perth dt)           ; echo "[$_t] Perth"'
alias dt-pitcairn='_t=$(TZ=Pacific/Pitcairn dt)       ; echo "[$_t] Pitcairn"'
alias dt-prague='_t=$(TZ=Europe/Prague dt)            ; echo "[$_t] Prague"'
alias dt-reykjavik='_t=$(TZ=Atlantic/Reykjavik dt)    ; echo "[$_t] Reykjavík"'
alias dt-santiago='_t=$(TZ=America/Santiago dt)       ; echo "[$_t] Santiago"'
alias dt-saopaulo='_t=$(TZ=America/Sao_Paulo dt)      ; echo "[$_t] São Paulo"'
alias dt-seoul='_t=$(TZ=Asia/Seoul dt)                ; echo "[$_t] Seoul"'
alias dt-sitka='_t=$(TZ=America/Sitka dt)             ; echo "[$_t] Sitka"'
alias dt-sofia='_t=$(TZ=Europe/Sofia dt)              ; echo "[$_t] Sofia"'
alias dt-southpole='_t=$(TZ=Antarctica/South_Pole dt) ; echo "[$_t] South Pole"'
alias dt-stlucia='_t=$(TZ=America/St_Lucia dt)        ; echo "[$_t] St Lucia"'
alias dt-stockholm='_t=$(TZ=Europe/Stockholm dt)      ; echo "[$_t] Stockholm"'
alias dt-sydney='_t=$(TZ=Australia/Sydney dt)         ; echo "[$_t] Sydney"'
alias dt-tahiti='_t=$(TZ=Pacific/Tahiti dt)           ; echo "[$_t] Tahiti"'
alias dt-tokyo='_t=$(TZ=Asia/Tokyo dt)                ; echo "[$_t] Tokyo"'
alias dt-toronto='_t=$(TZ=America/Toronto dt)         ; echo "[$_t] Toronto"'
alias dt-utc='_t=$(TZ=UTC dt)                         ; echo "[$_t] UTC"'
alias dt-vienna='_t=$(TZ=Europe/Vienna dt)            ; echo "[$_t] Vienna"'
alias dt-vladivostok='_t=$(TZ=Asia/Vladivostok dt)    ; echo "[$_t] Vladivostok"'
alias dt-whitehorse='_t=$(TZ=America/Whitehorse dt)   ; echo "[$_t] Whitehorse"'
alias dt-yellowknife='_t=$(TZ=America/Yellowknife dt) ; echo "[$_t] Yellowknife"'
alias dt-zagreb='_t=$(TZ=Europe/Zagreb dt)            ; echo "[$_t] Zagreb"'
alias dt-zurich='_t=$(TZ=Europe/Zurich dt)            ; echo "[$_t] Zürich"'

# --- end timestamp }}}
# --- tmux {{{

if [[ -n "$TMUX" ]]; then
  alias clear='clear; tmux clear-history'
  alias reset='reset; tmux clear-history'
fi

# --- end tmux }}}
# --- units {{{

[[ -n "$_has_units" ]] \
  && alias units='units --history $HOME/.config/units/history'

# --- end units }}}
# --- vim {{{

alias :e='"$EDITOR"'
if [[ -n "$_has_vim" ]]; then
  # tell vim not to attempt connection with X server
  alias vim='vim -X'
  alias view='vim -R'
  alias vime='vim -u $HOME/.vim/vimrc.encrypt -x'
  alias viml='vim -u $HOME/.vim/vimrc.lite'
  alias vimmin='vim \
    -u NONE \
    -U NONE \
    --cmd "set nocompatible | syntax on | filetype plugin indent on"'
  alias rvim='vim -Z'
  alias rview='view -Z'
fi
if [[ -n "$_has_nvim" ]]; then
  alias nv='nvim'
  alias nview='nvim -R'
fi

# --- end vim }}}
# --- wget {{{

[[ -n "$_has_wget" ]] \
  && alias wget='wget \
    --config=$HOME/.config/wget/wgetrc \
    --hsts-file=$HOME/.config/wget/wget-hsts'

# --- end wget }}}

# end aliases }}}
# ==============================================================================
# functions {{{

for _fn in $(find "$HOME/.functions.d" -type f -name "*.sh"); do
  source "$_fn"
done

# end functions }}}
# ==============================================================================
# completions {{{

[[ -r '/usr/share/bash-completion/bash_completion' ]] \
  && source /usr/share/bash-completion/bash_completion

# improve git completion for git aliases
if declare -F __git_complete > /dev/null; then
  __git_complete g git
  __git_complete gc git_commit
  __git_complete gd git_diff
  __git_complete gpl git_pull
  __git_complete gps git_push
  __git_complete gs git_status
fi

# end completions }}}
# ==============================================================================
# system {{{

if [[ -x "$HOME/.bin/voidinfo" && -z "$VIMRUNTIME" ]]; then
  if ! [[ "$UID" == '0' ]]; then
    voidinfo -c green
  else
    voidinfo -c red
  fi
fi

# end system }}}
# ==============================================================================
# software {{{

# --- beam {{{

# enable repl history
export ERL_AFLAGS='-kernel shell_history enabled'

# --- end beam }}}
# --- cryfs {{{

export CRYFS_NO_UPDATE_CHECK=true

# --- end cryfs }}}
# --- diffr {{{

if [[ -n "$_has_diffr" ]]; then
  unset DIFFR
  # from junegunn/seoul256.vim rgb_map: 65 => #5f875f
  DIFFR+=' --colors refine-added:none:background:95,135,95'
  # from junegunn/seoul256.vim rgb_map: 131 => #af5f5f
  DIFFR+=' --colors refine-removed:none:background:175,95,95'
  # use seoul256 colors
  alias diffr="diffr $DIFFR"
  # for git config and diffrous
  export DIFFR
fi

# --- end diffr }}}
# --- elixir {{{

export HEX_HOME="$XDG_DATA_HOME/hex"
export MIX_HOME="$XDG_DATA_HOME/mix"

# --- end elixir }}}
# --- fzf {{{

# use fd as default source for fzf, incl alt+c ctrl+t and ** completion
if [[ -n "$_has_fd" ]]; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden'
  export FZF_ALT_C_COMMAND='fd --type d --hidden'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  _fzf_compgen_path() { $FZF_DEFAULT_COMMAND; }
fi

# use multi-select and seoul256 colors
export FZF_DEFAULT_OPTS='
  --multi
  --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

# improved preview
[[ -n "$_has_tree" ]] \
  && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -$LINES'" \
  && export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null \
    | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' \
  --preview-window down:3:hidden \
  --bind ?:toggle-preview"

# source fzf completions
[[ -r '/usr/share/doc/fzf/completion.bash' ]] \
  && source /usr/share/doc/fzf/completion.bash
# source fzf key bindings
[[ -r '/usr/share/doc/fzf/key-bindings.bash' ]] \
  && source /usr/share/doc/fzf/key-bindings.bash
# source fzf functions
[[ -r "$HOME/.fzf-extras/fzf-extras.sh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.sh"

# --- end fzf }}}
# --- gerbil {{{

export GERBIL_GSC='/usr/bin/gambit-gsc'
export GERBIL_HOME='/usr/lib/gerbil'

# --- end gerbil }}}
# --- gpg {{{

# refresh gpg-agent tty
if ! [[ "$UID" == '0' ]]; then
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# --- end gpg }}}
# --- ip {{{

export INTERFACE="$(interface)"

# --- end ip }}}
# --- postgresql {{{

export PSQLRC="$HOME/.config/pg/psqlrc"
export PGPASSFILE="$HOME/.config/pg/pgpass"
export PGSERVICEFILE="$HOME/.config/pg/pg_service.conf"

# --- end postgresql }}}
# --- raku {{{

export RAKUDO_HOME='/usr/lib/raku'

# --- end raku }}}
# --- rlwrap {{{

export RLWRAP_HOME="$HOME/.config/rlwrap"

# %L,%C = line, column number of cursor position in rlwrap's edit buffer
export RLWRAP_EDITOR="vim '+call cursor(%L,%C)'"

# --- end rlwrap }}}
# --- ruby {{{

export IRBRC="$HOME/.config/irb/irbrc"

# --- end ruby }}}
# --- rust {{{

# only shell-complete Cargo.toml
export FIGNORE="argo.lock"

# --- end rust }}}
# --- screen {{{

export SCREENRC="$HOME/.config/screen/screenrc"

# --- end screen }}}
# --- xtools {{{

export XLOCATE_GIT="$HOME/.config/xtools/xlocate.git"

# --- end xtools }}}

# end software }}}
# ==============================================================================

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
