autoload -U promptinit; promptinit

# path
export LANG="ja_JP.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM="xterm-256color"
export MYVIMRC="$HOME/.vimrc"
export GOPATH="$HOME/go"
export VIMRUNTIME="~/.vim"
# PATH は順序考慮してここで一括設定(優先度: go/yarn > homebrew > system > flutter/local)
# gcloud は mise 管理に移行(下部の mise activate 後で path/completion を読み込む)
# mise の shims は `mise activate`(後述)が最終的に先頭へ追加する
export PATH="$GOPATH/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Documents/flutter/bin:$HOME/.local/bin"

# setup node (node 本体は mise で管理。yarn 系の PATH は上部に集約)

export GIT_WORKTREE_DIR="${HOME}/.gitworktree"

# setup golang (go 本体は mise で管理。GOPATH と $GOPATH/bin は上部に集約)
export GOPROXY="https://proxy.golang.org"

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
source ~/.zplug/init.zsh
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
# direnv フックは mise の有効化後(ファイル末尾)で実行する(direnv は mise 管理のため)

# alias
alias ls='ls -G'
alias l='ls -G'
alias la='ls -a'
alias ll='ls -la'
alias up='cd ..'
alias cwo='cd ~/Documents/workspace'
alias ck='cd ~/Documents/workspace/canary/canary-cloud-kanri'
alias mv='mv -i'
alias cdr='cd-gitroot'
alias cd='cdls'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gm='git switch main || git switch master && git pull'
alias gpf='git push -f'
alias gb='git branch -avv'
alias gr='dirname "$(git rev-parse --git-common-dir 2>/dev/null)"' # 現在のディレクトリのgitルートディレクトリを取得
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
alias tree='tree -a -I "\.DS_Store|\.git|node_modules|vendor\/bundle" -N'
alias gdel=git branch --merged master|egrep -v '\*|develop|master'|xargs git branch -d
alias rm='trash'

# gcloud の path/completion は mise 管理に移行したため、ファイル末尾(mise activate 後)で読み込む

function hankyo() {
	TEXT=$1
  echo $TEXT | nkf | pbcopy
}

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

function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

set termguicolors
# let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
# let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

# fbr - switch git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  # もし現在いるworktreeと異なる名前のブランチへswitchするばあいはエラーをだす
  selected_branch=$(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)" | tr -d " " | fzf --height 70% --prompt "SWITCH BRANCH>" --preview "git log -p --color=always {}" --preview-window up | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")
  if [ "$(git rev-parse --abbrev-ref HEAD)" != "$selected_branch" ]; then
    echo "エラー: 現在いるworktreeと異なる名前のブランチへswitchすることはできません。"
    return 1
  fi
  git switch -f $selected_branch
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
	selected=$(unbuffer git status --short | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" --preview-window up | awk '{print $2}')
		if [[ -n "$selected" ]]; then
			selected=$(tr '\n' ' ' <<< "$selected")
			for s in ${=selected}; do
				git add $s
			done
		fi
}

fres() {
	local selected
	selected=$(unbuffer git status --short | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" --preview-window up | awk '{print $2}')
		if [[ -n "$selected" ]]; then
			selected=$(tr '\n' ' ' <<< "$selected")
			for s in ${=selected}; do
				git reset $s
			done
		fi
}

fco() {
	local selected
	selected=$(unbuffer git status --short | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" --preview-window up | awk '{print $2}')
		if [[ -n "$selected" ]]; then
			selected=$(tr '\n' ' ' <<< "$selected")
			for s in ${=selected}; do
				git switch $s
			done
		fi
}


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fh - repeat history
function fh() {
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}

zle -N fh
bindkey '^r' fh

# fch - browse chrome history
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

# 各種パッケージマネージャを一括アップデートするルーチン
# 1つのステップが失敗しても止まらず最後まで走り、結果サマリを表示する
routine() {
  local -a steps=(
    "gcloud:gcloud components update --quiet"
    "brew update:brew update"
    "brew upgrade:brew upgrade"
    "brew cask:brew upgrade --cask --greedy"
    "brew cleanup:brew cleanup -s"
    "mise:mise upgrade"          # config.toml の minimum_release_age=7d により7日未満のリリースは除外される
    "zplug:zplug update"
  )
  local -a failed=()
  local step name cmd
  for step in "${steps[@]}"; do
    name="${step%%:*}"
    cmd="${step#*:}"
    print -P "%F{cyan}==> ${name}%f"
    # コマンドが見つからない場合はスキップ(全環境に全ツールがあるとは限らない)
    if ! command -v "${cmd%% *}" >/dev/null 2>&1; then
      print -P "%F{yellow}    (skip: ${cmd%% *} not found)%f"
      continue
    fi
    if ! eval "$cmd"; then
      failed+=("$name")
      print -P "%F{red}    !! ${name} failed%f"
    fi
  done

  print -P "\n%F{cyan}==> routine done%f"
  if (( ${#failed} )); then
    print -P "%F{red}failed: ${(j:, :)failed}%f"
    return 1
  fi
  print -P "%F{green}all updates succeeded%f"
}

# brew install/uninstall/tap を ~/.Brewfile に自動反映する
# パッケージ構成を変える操作の後だけ Brewfile 全体を再生成する(--describe で各エントリに説明コメントを付与)
brew() {
  command brew "$@"
  local ret=$?
  # 構成変更コマンドが成功したときのみ dump する(typo 等での失敗時は再生成しない)
  if [[ $ret -eq 0 ]]; then
    case "$1" in
      install|uninstall|remove|rm|tap|untap)
        command brew bundle dump --global --force --describe
        ;;
    esac
  fi
  return $ret
}

kfilter() {
    cat - | yq r - -d "*" -j | \
        jq ".[] | select(.kind | match(\"$1\";\"i\")) | select(.metadata.name==\"$2\")" \
        | jq . -s | yq r -
}

#nt
nts() {
  id=$(nt todo l --id=true | fzf | awk -F'[:]' '{print $2}'| xargs echo| sed 's/ //')
  nt todo s $id
}

wadd() {
  git worktree add $(gr)/.gitworktree/$1 -b $1 && \
  cd $(gr)/.gitworktree/$1 && \
}

wsw() {
  cd $(gr)/.gitworktree/$1
}

wbr() {
  # 出力行の一行目をトリミング
  # selected=$(git worktree list | sed '1d' | sed -n 's/.*\[\(.*\)\]/\1/p' | fzf --height 70% --prompt "SWITCH WORKTREE>")
  selected=$(git worktree list | sed -n 's/.*\[\(.*\)\]/\1/p' | fzf --height 70% --prompt "SWITCH WORKTREE>")
  # selected=$(git worktree list | sed '1d' | fzf --height 70% --prompt "SWITCH WORKTREE>" --preview "git log -p --color=always {}" --preview-window up | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g" | sed -n 's/.*\[\(.*\)\]/\1/p')

  # selectedがmainかmasterであればルートディレクトリ二移動
  if [ "$selected" = "main" ] || [ "$selected" = "master" ]; then
    cd $(gr)
  else
    cd $(gr)/.gitworktree/$selected
  fi
}

wp() {
  cd $(gr)
  # $(gr)/.gitworktreeのディレクトリごとにpruneとrm -rfを実行
  for dir in $(gr)/.gitworktree/*; do
    git worktree remove -f $dir
    rm -rf $dir
  done
}

# mise (Claude Code などのツールを PATH に通す。shims は activate が PATH 先頭へ追加する)
eval "$(mise activate zsh)"

# gcloud (mise 管理)。バージョン非依存に mise where で実体を解決し、PATH と補完を読み込む
GCLOUD_HOME="$(mise where gcloud 2>/dev/null)"
if [ -n "$GCLOUD_HOME" ]; then
  [ -f "$GCLOUD_HOME/path.zsh.inc" ] && . "$GCLOUD_HOME/path.zsh.inc"
  [ -f "$GCLOUD_HOME/completion.zsh.inc" ] && . "$GCLOUD_HOME/completion.zsh.inc"
fi
unset GCLOUD_HOME

# direnv フック(mise が direnv を PATH に通した後に実行する)
eval "$(direnv hook zsh)"
