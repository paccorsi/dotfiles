# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git
alias gamend="git commit --amend --no-edit"
alias ga.="git add ."
alias gb="git branch"
alias gclean='git branch -d `git branch --merged | grep -v "^*" | tr -d "\n"`'
alias gr="git rebase"
alias grm="git rebase master"
alias gs="git status"
alias gpl="git pull"
alias gstop="gco origin/master -- "
alias gD="git diff HEAD~1 HEAD"
alias gd="git diff"
alias gco="git checkout"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpn="git push --no-verify"
alias gf="git fetch"

function gcm () {
  local main=$(basename $(git symbolic-ref --short refs/remotes/origin/HEAD))
  git checkout "$main"
}

function gcp () {
  git add --all
  git commit -m "$1"
  git push origin HEAD
}

function gC () {
  git commit --amend --no-edit
  git push origin +HEAD
}

# Kube
alias k='kubectl'
alias kg='kubectl get'
alias kex='kubectl exec -it'

# Docker
alias doit="docker exec -it"

# Mac
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Unix
alias cd..="cd .."
alias l="exa"
alias tree="exa --tree"
alias la="exa --long --header --time-style=long-iso"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"
alias dirdus"=du -sckx * | sort -nr" # directories sorted by size
alias dus="du -kx | sort -nr | less" # files sorted by size
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path

# Python
alias t="py.test -vv" 

