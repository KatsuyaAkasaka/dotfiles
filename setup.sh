#!/bin/zsh

# 必ずホームディレクトリ上で実行すること!!
cd ~

# system.logを初期化
: > ./system.log

# 実行内容一覧
HOMEBREW_INSTALL="Install homebrew"
GIT_INSTALL="Install git"
GIT_CLONE="Clone dotfiles"

EXECUTE_LIST=("$HOMEBREW_INSTALL", "$GIT_INSTALL", "$GIT_CLONE")

# loadingの標準出力用関数
i=1
loading () {
	echo "[Step$i/${#EXECUTE_LIST[@]}]"
    (( i++ ))
	while :; do
		for X in '-' '\' '|' '/'; do
			printf "[$X]$2\r";
			sleep 0.1;
		done;
        if test ! $(ps -p $1 > /dev/null); then
            break
        fi
	done
	echo "\nfinished!"
}

# homebrewのインストール
echo "[$HOMEBREW_INSTALL]" >> ./system.log
if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" >> ./system.log
else
	echo "[INFO] already intalled homebrew" >> ./system.log
fi &
homebrewPid=$!

loading $homebrewPid "Install homebrew"

# gitのインストール
echo "[$GIT_INSTALL]" >> ./system.log
if test ! $(which git); then
	brew install git >> ./system.log
else
	echo "[INFO] already intalled git" >> ./system.log
fi &
gitPid=$!

loading $gitPid "Install git"

# dotfilesのclone
echo "[$GIT_CLONE]" >> ./system.log
git clone https://github.com/KatsuyaAkasaka/dotfiles >> ./system.log &
clonePid=$!

loading $clonePid "Clone dotfiles"
wait $homebrewPid $gitPid $clonePid
