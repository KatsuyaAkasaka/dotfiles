autoload -U promptinit; promptinit
prompt pure

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
# export NODEPATH="$HOME/.nodenv"
export NODEPATH="$HOME/.nodebrew/current"
export MYVIMRC="$HOME/.vimrc"
export GCLOUDPATH="$HOME/google-cloud-sdk"
export PGDATA='/usr/local/var/postgres'
export PATH="$PGDATA:$NODEPATH/bin:$GCLOUDPATH/bin:$RBPATH:$PYPATH:$GOENV_ROOT/bin:$GOPATH/bin:/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
eval "$(rbenv init - zsh)"
eval "$(pyenv init - zsh)"
eval "$(goenv init - zsh)"
eval "$(nodenv init - zsh)"

# other
autoload -Uz compinit && compinit
setopt auto_list
setopt auto_menu
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#zplug
export ZPLUG_HOME="$HOME/.zplug"
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure"
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

zplug load --verbose

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
alias mv='mv -i'
alias cp='cp -i'
alias cdr='cd-gitroot'
alias cd='cdls'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push -f'
alias gb='git branch -avv'
alias cpath='pwd | pbcopy'
alias d='docker'
alias dc='docker-compose'
alias k='kubectl'
alias npmt='npm run test'
alias npms='npm run start'
alias npml='npm run lint'

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
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GOENV_DISABLE_GOPATH=1


