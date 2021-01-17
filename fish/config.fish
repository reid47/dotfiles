alias vim nvim
alias cls clear
alias gco "git checkout"
alias gst "git status"
alias gap "git add -p"
alias gpr "git pull -r"

# Make tmux behave kinda like vim
alias :q exit
alias :vsp "tmux split-window -h"
alias :sp "tmux split-window -v"

set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx GOPATH $HOME/code/go

set -gx PATH /usr/local/bin $PATH
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $PATH /usr/local/mysql/bin
set -gx PATH $PATH /usr/local/go/bin $GOPATH/bin
set -gx PATH $PATH $HOME/.cabal/bin
set -gx PATH $PATH $HOME/.ghcup/bin

# Remove default greeting
set -gx fish_greeting ""

# Colors
set -gx fish_color_command cyan
set -gx fish_color_error red
set -gx fish_color_quote yellow
set -gx fish_color_operator yellow
set -gx fish_color_end green
set -gx fish_color_param blue
set -gx fish_color_comment "#75715e"
set -gx fish_pager_color_description yellow
set -gx fish_pager_color_progress white --bold --background=blue

set -g fish_user_paths "/usr/local/opt/node@10/bin" $fish_user_paths

set -g fish_function_paths $HOME/.fisher $fish_function_paths
