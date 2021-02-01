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

log "Setting up fish shell..."
grep "/usr/local/bin/fish" /etc/shells || echo "/usr/local/bin/fish" >> /etc/shells
dscl . -read ~/ UserShell | grep "/usr/local/bin/fish" || chsh -s "/usr/local/bin/fish"
log_done

if [ -z "$SKIP_DEPS" ]; then
  brew_install_or_upgrade() {
    cmd_name="$1"
    brew_name="${2:-$cmd_name}"

    if ! command_exists $cmd_name; then
      log "Installing $brew_name..."
      brew install $brew_name
      log_done
    else
      log "Upgrading $brew_name..."
      brew upgrade $brew_name || true
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

  brew_install_or_upgrade python
  brew_install_or_upgrade nvim
  brew_install_or_upgrade rg ripgrep
  brew_install_or_upgrade jq
  brew_install_or_upgrade bat
  brew_install_or_upgrade fd
  brew_install_or_upgrade fish
  brew_install_or_upgrade fzf
  brew_install_or_upgrade n
  brew_install_or_upgrade exa
  brew_install_or_upgrade gh
  brew_install_or_upgrade tldr
  brew_install_or_upgrade tmux
  brew_install_or_upgrade httpie
fi

log "Linking scripts..."
for script in `fd -t x . scripts/ -a`; do
  script_name=$(basename "$script")
  ln -sv "$script" "/usr/local/bin/$script_name"
done
log_done
