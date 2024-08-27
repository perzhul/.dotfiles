# Utilities
function grep     ; command grep --color=auto $argv ; end

# mv, rm, cp verbose
abbr mv 'mv -v'
abbr rm 'rm -v'
abbr cp 'cp -v'

alias chmox='chmod +x'

# typos and abbreviations
abbr g git
abbr gti git
abbr yearn yarn
abbr v vim
abbr bwre brew
abbr brwe brew
abbr ta tmux attach
abbr tmuxa tmux attach
abbr gp git pull

alias push="git push"

# `g co`, etc. subcommand expansion with `abbr`.
function subcommand_abbr
  set -l cmd "$argv[1]"
  set -l short "$argv[2]"
  set -l long "$argv[3]"

  # Check that these strings are safe, since we're going to eval. 👺
  if not string match --regex --quiet '^[a-z]*$' "$short"
    or not string match --regex --quiet '^[a-z- ]*$' "$long"
    echo "Scary unsupported alias or expansion $short $long"; exit 1; 
  end

  set -l abbr_temp_fn_name (string join "_" "abbr" "$cmd" "$short")
  # Subcommand arg expanesion via commandline -tokenize + abbr --position anywhere
  # thx lgarron for inspiration: https://github.com/lgarron/dotfiles/blob/2bc3e0282b/dotfiles/fish/.config/fish/abbr.fish & https://github.com/lgarron/dotfiles/blob/main/dotfiles/fish/.config/fish/dev.fish
  # https://www.reddit.com/r/fishshell/comments/16s0bsi/leveraging_abbr_for_git_aliases/
  set -l abbr_temp_fn "function $abbr_temp_fn_name
    set --local tokens (commandline --tokenize)
    if test \$tokens[1] = \"$cmd\"
      echo $long
    else
      echo $short
    end; 
  end; 
  abbr --add $short --position anywhere --function $abbr_temp_fn_name"
  eval "$abbr_temp_fn"
end

subcommand_abbr git c "commit -am"
subcommand_abbr git tc "commit -am"
subcommand_abbr git cm "commit --no-all -m"
subcommand_abbr git co "checkout"
subcommand_abbr git c "commit -am"
subcommand_abbr git s "status"
subcommand_abbr git ts "status"
subcommand_abbr git amend "commit --amend --all --no-edit"
subcommand_abbr git hreset "reset --hard"
subcommand_abbr git cp "cherry-pick"
subcommand_abbr git cherrypick "cherry-pick"
subcommand_abbr git dif "diff"

alias gitmainormaster="git branch --format '%(refname:short)' --sort=-committerdate --list master main | head -n1"
alias main="git checkout (gitmainormaster)"
alias master="main"

alias sorteduniq="sort | uniq -c | sort --reverse --ignore-leading-blanks --numeric-sort" # -rbn
alias sorteduniq-asc="sort | uniq -c | sort --ignore-leading-blanks --numeric-sort"  # -bn

alias diskspace_report="df -lh | egrep ' (Mounted on)|(/\$)' "
alias free_diskspace_report="diskspace_report"

alias hosts='sudo $EDITOR /etc/hosts'   # yes I occasionally 127.0.0.1 twitter.com ;)

alias dotfiles="vim ~/.dotfiles" # open dotfiles for viewing

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# File size
alias fs="stat -f \"%z bytes\""

# Update installed Ruby gems, Homebrew, npm, and their installed packages
alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; npm-check -g -u"
alias update_brew_npm_gem='brew_update; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update --no-document'

