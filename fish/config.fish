set fish_greeting ""

set -g -x work ~/work/
set -g -x dotfiles ~/.dotfiles

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


alias vim=nvim
alias work="vim ~/work/geopie/"
alias todo="vim ~/personal/todo.md"
alias fishc="vim ~/.dotfiles/fish/config.fish"
alias vimrc="vim ~/.dotfiles/nvim/init.vim"

# Set the default editor to Neovim
set -x EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

alias ls="lsd --group-dirs first"
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'

alias dcd="docker compose down"
alias dcu="docker compose up"
alias dcb="docker compose build"
alias dcr="docker compose restart"
alias dcs="docker compose stop"
alias dcp="docker compose pull"
alias ds="docker ps"

alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gpl="git pull"

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

function set_nvm_default --description 'Set the universal default Node.js version for NVM'
    if count $argv > /dev/null
        set --universal nvm_default_version $argv[1]
        echo "NVM default version set to $argv[1]"
    else
        echo "Please specify a Node.js version to set as default."
    end
end
