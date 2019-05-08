# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias p="pygmentize"

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
alias gcm="git checkout master"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gf="git fetch"

function gCP () {
    git add --all
    git commit -m "$1"
    git push origin HEAD
}

function gC () {
    git commit --amend --no-edit
    git push origin +HEAD
}

# Mac
alias cask="brew cask"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Unix
alias cd..="cd .."
alias l="exa"
alias la="exa -bghHliS"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"
alias lsd="ls -ld *" # show directories
alias dirdus"=du -sckx * | sort -nr" # directories sorted by size
alias dus="du -kx | sort -nr | less" # files sorted by size
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path

# Python
alias t="py.test -vv" 

