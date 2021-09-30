#!/bin/zsh

# 必ずホームディレクトリ上で実行すること!!
cd ~

# 実行内容一覧
HOMEBREW_INSTALL="Install homebrew"
GIT_INSTALL="Install git"
GIT_CLONE="Clone dotfiles"

# homebrewのインストール
echo "Install homebrew"
if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "[INFO] already intalled homebrew"
fi

# gitのインストール
echo "Install git"
if test ! $(which git); then
	brew install git
else
	echo "[INFO] already intalled git"
fi

# dotfilesのclone
echo "Clone dotfiles"
git clone https://github.com/KatsuyaAkasaka/dotfiles
