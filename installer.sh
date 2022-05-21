echo "Installing your essencialy package to this mahine..."


DOT_DIRECTORY=$HOME/dotfiles

echo "Setting vim..."
$DOT_DIRECTORY/vim/setup.sh
echo "Setting zsh..."
$DOT_DIRECTORY/zsh/setup.sh

echo "vscode vim enable to repeating..."
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider

echo "gcloud setup..."
gcloud config configurations create sakas
gcloud config set project rich-suprstate-283005
gcloud auth login

echo "Finished!! Let's go!!"
