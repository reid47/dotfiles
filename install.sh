#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

log() {
  printf "\n$1\n"
}

command_exists() {
  type "$1" &> /dev/null
}

brew_install_or_upgrade() {
  if ! command_exists $1; then
    log "Installing $1..."
    brew install $2
  else
    log "Upgrading $1..."
    brew upgrade $2 || true
  fi
}

log "Linking config files..."
ln -sfv $dir/.bashrc $HOME/.bashrc
ln -sfv $dir/.bash_profile $HOME/.bash_profile
ln -sfv $dir/.gitconfig $HOME/.gitconfig
ln -sfv $dir/.tmux.conf $HOME/.tmux.conf
ln -sfv $dir/nvim/ $HOME/.config
ln -sfv $dir/fish/ $HOME/.config

log "Installing vim plugins..."
nvim --headless +UpdateAllPlugins +qall

log "Downloading z to ~/z.sh..."
curl https://raw.githubusercontent.com/rupa/z/master/z.sh -s -o $HOME/z.sh

log "Configuring iTerm2..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dir"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

if ! command_exists brew; then
  log "Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
else
  log "Updating brew..."
  brew update
fi

brew_install_or_upgrade nvim nvim
brew_install_or_upgrade rg ripgrep
brew_install_or_upgrade jq jq
brew_install_or_upgrade bat bat
brew_install_or_upgrade fd fd
brew_install_or_upgrade fzf fzf
brew_install_or_upgrade n n

log "Installing fish plugins..."
fish "$dir/fish/install.fish"
