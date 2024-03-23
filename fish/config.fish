set -g -x work ~/work/
set -g -x dotfiles ~/.dotfiles

alias vim=nvim
alias work="vim ~/work/geopie/"
alias todo="vim ~/personal/todo.md"

alias ls="lsd"
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

