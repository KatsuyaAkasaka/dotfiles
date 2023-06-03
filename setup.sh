#!/bin/sh

# 必ずホームディレクトリ上で実行すること!!
cd $HOME

# homebrewのインストール
if ! which brew > /dev/null 2>&1; then
	echo "Install homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# armベースPCの場合はbrewにパスを通す必要あり
	if uname -m | grep --quiet "arm64" 2>&1 > /dev/null ; then
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
else
	echo "[INFO] already intalled homebrew"
fi
# arm用pathを通しておく
export PATH="$PATH:/opt/homebrew/bin" 

# gitのインストール
if ! which git > /dev/null 2>&1; then
	echo "Install git"
	brew install git
else
	echo "[INFO] already intalled git"
fi

# dotfilesのclone
if ! -e $HOME/dotfiles > /dev/null 2>&1; then
	echo "Clone dotfiles"
	git clone https://github.com/KatsuyaAkasaka/dotfiles
else
	echo "[INFO] already cloned dotfile"
fi

# workspace作成
if ! -e $HOME/Documents/workspace > /dev/null 2>&1; then
	mkdir $HOME/Documents/workspace
else
	echo "[INFO] already created workspace directory"
fi
