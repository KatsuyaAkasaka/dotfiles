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
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# m1macの場合はbrewにパスを通す必要あり
	if uname -m | grep --quiet "arm64" 2>&1 > /dev/null ; then
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
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
