# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git
alias gclean='git branch -d `git branch --merged | grep -v "^*" | tr -d "\n"`'
alias gr="git rebase"
alias grm="git rebase master"
alias gs="git status"
alias gpl="git pull"
alias gstop="gco origin/master -- "
alias gD="git diff HEAD~1 HEAD"

function gCP () {
    git add --all
    git commit -m "$1"
    git push origin HEAD
}

function gC () {
    git add --all
    git commit --amend -C HEAD
    git push origin +HEAD
}

# Mac
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Unix
alias cd..="cd .."
alias la="ls -la"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"
alias lsd="ls -ld *" # show directories
alias dirdus"=du -sckx * | sort -nr" # directories sorted by size
alias dus="du -kx | sort -nr | less" # files sorted by size
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path

# Bundler
alias b="bundle"
alias be="bundle exec"

# Rails
alias migrate="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias s="rspec"

# Misc
alias cask="brew cask"
