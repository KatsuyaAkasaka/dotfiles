autoload -U promptinit; promptinit

# path
export LANG="ja_JP.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM="xterm-256color"
export RBPATH="$HOME/.rbenv/bin"
export PYPATH="$HOME/.pyenv/bin"
export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/go"
export GOPROXY="https://proxy.golang.org"
export GO111MODULE="on"
export PYENV_ROOT="$HOME/.pyenv"
export MYVIMRC="$HOME/.vimrc"
export GCLOUDPATH="$HOME/google-cloud-sdk"
export PGDATA='/usr/local/var/postgres'
export VIMRUNTIME="~/.vim"
export PATH="$PGDATA:$GCLOUDPATH/bin:$RBPATH:$GOPATH/bin:/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Documents/flutter/bin:$HOME/.local/bin:/opt/homebrew/bin"
eval "$(rbenv init - zsh)"

#setup node
export NODENV_ROOT="$HOME/.nodenv"
PATH="$NODENV_ROOT/bin:$NODENV_ROOT/shims:$PATH"

# setup python
PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#setup golang
PATH="$GOENV_ROOT/bin::$PATH"
eval "$(goenv init - zsh)"

# zsh setting
autoload -Uz compinit && compinit  # 補完
setopt auto_pushd  # cdのタイミングで自動的にpushd
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完キー連打で順に補完候補を自動で補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt auto_param_keys  # カッコの対応などを自動的に補完
setopt nolistbeep  # 補完候補表示時にビープ音を鳴らさない
setopt hist_expand  # 補完時にヒストリを自動的に展開する
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2  # 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 補完の時に大文字小文字を区別しない


#zplug
source /usr/local/opt/zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "ascii-soup/zsh-url-highlighter"
if [[ $ZPLUG_LOADFILE -nt $ZPLUG_CACHE_DIR/interface || ! -f $ZPLUG_CACHE_DIR/interface ]]; then
	zplug check || zplug install
fi

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

zplug load

zstyle :prompt:pure:git:stash show yes
prompt pure

# .direnv
export EDITOR="vim"
eval "$(direnv hook zsh)"

# alias
alias ls='ls -G'
alias l='ls -G'
alias la='ls -a'
alias ll='ls -la'
alias up='cd ..'
alias cmi='cd ~/Documents/workspace/miami'
alias cco='cd ~/Documents/workspace/cocolocala'
alias mv='mv -i'
alias cdr='cd-gitroot'
alias cd='cdls'
alias vim='nvim'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push -f'
alias gb='git branch -avv'
alias cpath='pwd | pbcopy'
alias d='docker'
alias dc='docker-compose'
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias npmt='npm run test'
alias npms='npm run start'
alias npml='npm run lint'
alias npmd='npm run dev'
alias npmb='npm run build'
alias gip='curl -XGET httpbin.org/ip | jq .origin'

# The next line updates PATH for the Google Cloud SDK
if [ -f '/Users/sakas/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sakas/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sakas/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sakas/google-cloud-sdk/completion.zsh.inc';
fi

function readlink() {
	TARGET_FILE=$1

	cd `dirname $TARGET_FILE`
	TARGET_FILE=`basename $TARGET_FILE`

	# Iterate down a (possible) chain of symlinks
	while [ -L "$TARGET_FILE" ]
	do
		TARGET_FILE=`readlink $TARGET_FILE`
		cd `dirname $TARGET_FILE`
		TARGET_FILE=`basename $TARGET_FILE`
	done

	# Compute the canonicalized name by finding the physical path
	# for the directory we're in and appending the target file.
	PHYS_DIR=`pwd -P`
	RESULT=$PHYS_DIR/$TARGET_FILE
	echo $RESULT
}

function cdls() {
  # cdがaliasでループするので\をつける
  \cd "$@" && ls
}

set termguicolors
# let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
# let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

# fbr - checkout git branch
# fbr() {
#   local branches branch
#   branches=$(git branch -vv) &&
#   branch=$(echo "$branches" | fzf +m) &&
#   git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
# }
# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fadd() {
	local selected
	selected=$(unbuffer git status --short | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color"  | awk '{print $2}')
		if [[ -n "$selected" ]]; then
			selected=$(tr '\n' ' ' <<< "$selected")
			for s in ${=selected}; do
				git add $s
			done
		fi
}

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GOENV_DISABLE_GOPATH=1

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# c - browse chrome history
fch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s06164/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/s06164/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s06164/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/s06164/google-cloud-sdk/completion.zsh.inc'; fi
