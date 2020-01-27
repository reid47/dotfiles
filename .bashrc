# Aliases:
alias ..="cd .."
alias ...="cd ../.."
alias cls="clear"
alias gco="git checkout"
alias gst="git status"
alias la="ls -lahGF"
alias lc="wc -l"
alias vim="nvim"

# Path:
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$PATH:/usr/local/mysql/bin"
export PATH

# Prompt:
red="$(tput setaf 1)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"

git_branch() {
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -z $branch ]; then
    # not a git repo
    echo ""
  elif [ -n "$(git status -s)" ]; then
    # uncommitted changes
    echo " ${red}(${branch})"
  else
    # no changes
    echo " ${reset}(${branch})"
  fi
}

export PS1="\n\[${green}\]\w\$(git_branch)\n\[${blue}\]\$\[${reset}\] "
export PS2="\[${blue}\]...\[${reset}\] "

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# z
source $HOME/z.sh
