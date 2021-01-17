#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

log() {
  printf "\n$(tput setaf 5)$1$(tput sgr0)\n"
}

log_done() {
  printf "$(tput setaf 2)Done!$(tput sgr0)\n"
}

command_exists() {
  type "$1" &> /dev/null
}

log "Linking config files..."
ln -sfv $dir/gitconfig $HOME/.gitconfig
ln -sfv $dir/tmux.conf $HOME/.tmux.conf
ln -sfv $dir/nvim/ $HOME/.config
ln -sfv $dir/fish/ $HOME/.config
log_done

log "Installing vim plugins..."
nvim --headless +UpdateAllPlugins +qall
log_done

log "Configuring iTerm2..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dir"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
log_done

log "Running fish setup script..."
fish "$dir/fish/install.fish"
log_done

if [ -z "$SKIP_DEPS" ]; then
  brew_install_or_upgrade() {
    if ! command_exists $1; then
      log "Installing $1..."
      brew install $2
      log_done
    else
      log "Upgrading $1..."
      brew upgrade $2 || true
      log_done
    fi
  }

  if ! command_exists brew; then
    log "Installing brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
    log_done
  else
    log "Updating brew..."
    brew update
    log_done
  fi

  brew_install_or_upgrade nvim nvim
  brew_install_or_upgrade rg ripgrep
  brew_install_or_upgrade jq jq
  brew_install_or_upgrade bat bat
  brew_install_or_upgrade fd fd
  brew_install_or_upgrade fzf fzf
  brew_install_or_upgrade n n
  brew_install_or_upgrade exa exa
  brew_install_or_upgrade gh gh
fi
