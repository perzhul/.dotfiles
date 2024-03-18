alias vim=nvim
alias ls="lsd -a"
alias work="vim ~/work/geopie/"

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item
set -g -x work ~/work
