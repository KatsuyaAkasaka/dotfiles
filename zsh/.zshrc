autoload -U promptinit; promptinit
prompt pure

# path 
export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export RBPATH="$HOME/.rbenv/bin"
export PYPATH="$HOME/.pyenv/bin"
export GOENV_ROOT="$HOME/.goenv"
export GOPATH="$HOME/go"
export MYVIMRC="$HOME/.vimrc"
export PATH="$RBPATH:$PYPATH:$GOENV_ROOT/bin:$GOPATH/bin:/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
eval "$(rbenv init - zsh)"
eval "$(pyenv init - zsh)"
eval "$(goenv init - zsh)"

# other
autoload -Uz compinit && compinit
setopt auto_list
setopt auto_menu
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2


#zplug
export ZPLUG_HOME="$HOME/.zplug"
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug mafredri/zsh-async, from:github
zplug "sindresorhus/pure"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "ascii-soup/zsh-url-highlighter"

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

zplug load --verbose

# .envrc
export EDITOR="vim"
eval "$(direnv hook zsh)"

# alias
alias ls='ls -G'
alias l='ls -G'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias up='cd ..'
alias mv='mv -i'
alias cp='cp -i'
alias cdr='cd-gitroot'
alias cd='cdls'

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
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
