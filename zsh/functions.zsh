antibody_install() {
  antibody bundle < bundles.txt > .antibody_bundles.txt
}

pdf-rename() {
  exiftool exiftool "-filename<\${createdate} - \${author;} - \${title;}.%e" -d "%Y" "$@"
}

pip-update() {
  pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

# -------------------------------------------------------------------
# compressed file expander
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
extract() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

# --------------------------------------------------------------------
# ps with a grep
# from http://hiltmon.com/blog/2013/07/30/quick-process-search/
# --------------------------------------------------------------------
psax() {
  ps auxwwwh | grep "$@" | grep -v grep
}

# Reset audio
audioreset() {
    ps aux | grep coreaudio[d] | awk '{print $2}' | xargs sudo kill
}

# Make directory and change into it.
mcd() {
    mkdir -p "$1" && cd "$1";
}

# Change file extensions recursively in current directory
change_extension() {
    foreach f (**/*.$1)
        mv $f $f:r.$2
    end
}

# Update all the things
update() {
    brew cleanup
    brew update
    brew upgrade
    brew list > ~/.Brewfile
    antibody update
}

# make a backup of a file
bk() {
    local backup_name="${1}_$(date +%s)"
    echo "Backup: ${backup_name}"
    cp -a "$1" "${backup_name}"
}

# get the content type of an http resource
htmime() {
    if [[ -z $1 ]]; then
        print "USAGE: htmime <URL>"
        return 1
    fi
    mime=$(curl -sIX HEAD $1 | sed -nr "s/Content-Type: (.+)/\1/p")
    print $mime
}

# display a list of supported colors
lscolors() {
    ((cols = $COLUMNS - 4))
    s=$(printf %${cols}s)
    for i in {000..$(tput colors)}; do
        echo -e $i $(tput setaf $i; tput setab $i)${s// /=}$(tput op);
    done
}

# get public ip
myip() {
    local api
    case "$1" in
        "-4")
            api="http://v4.ipv6-test.com/api/myip.php"
            ;;
        "-6")
            api="http://v6.ipv6-test.com/api/myip.php"
            ;;
            *)
            api="http://ipv6-test.com/api/myip.php"
            ;;
    esac
    curl -s "$api"
    echo
}

# print a separator banner, as wide as the terminal
hr() {
    print ${(l:COLUMNS::=:)}
}

tar_dir() {
    tar \
      --exclude='./.git' \
      --exclude='./.mypy_cache' \
      --exclude='./.idea' \
      --exclude='./.cache' \
      -zcvf $1.tar.gz $1
}

decrypt() {
    openssl aes-256-cbc -d -a -in $1 -out $1.new
}

encrypt() {
    openssl aes-256-cbc -a -salt -in $1 -out $1.enc
}

# Prints the weather
weather() {
    if [ -z "$1" ]
    then
        curl -s wttr.in/Montreal | head -n 7
    else
        curl -s wttr.in/$1 | head -n 7
    fi
}

# fbr - checkout git branch (including remote branches)
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Fixup commit
gfix() {
  local fzf=(
		fzf \
		--ansi \
		--reverse \
		--tiebreak=index \
		--no-sort \
		--bind=ctrl-s:toggle-sort \
		--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
  )
  local commit=$(git cherry -v master | $fzf | awk '{print $2}')
  if [[ ! -z "$commit" ]]; then
    git commit --fixup=${commit}
    git rebase --interactive --autosquash ${commit}^
  fi
}

# fco - checkout git branch/tag
fco() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD             |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

# gl- git commit browser
gl() {
  local g=(
		git log
		--graph
		--format='%C(auto)%h%d %s %C(white)%C(bold)%cr'
		--color=always
		"$@"
	)

	local fzf=(
		fzf
		--ansi
		--reverse
		--tiebreak=index
		--no-sort
		--bind=ctrl-s:toggle-sort
		--preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
	)
	$g | $fzf
}

git-clean-branches() {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

git-pylint() {
  local new_files modified_files
  new_files=$(git status | grep 'new file:' | grep -e '.py$' | awk '{print $3}')
  modified_files=$(git status | grep 'modified:' | grep -e '.py$' | awk '{print $2}')

  if [[ -z $modified_files ]] && [[ -z $new_files ]]; then
    echo "No modified or new files found"
  fi

  for file in $modified_files $new_files 
  do
    pylint "${file}"
  done
}

# Run pytest on changed files
gst() {
  local new_files modified_files
  new_files=$(git status | grep 'new file:' | grep -e '^test_.*.py$' | awk '{print $3}')
  modified_files=$(git status | grep 'modified:' | grep -e 'test_.*.py$' | awk '{print $2}')

  if [[ -z $modified_files ]] && [[ -z $new_files ]]; then
    echo "No modified or new files found"
  fi

  for file in $modified_files $new_files
  do
    pytest "${file}"
  done
}

docker-clean() {
  # Stop all containers
  docker stop $(sudo docker ps -a -q)
  # Delete all containers
  docker rm $(sudo docker ps -a -q)
  # Delete all images
  docker rmi $(sudo docker images -q)
}

# Change gcloud project
function gcloud-project() {
  local current_project=$(gcloud config list project --format "value(core.project)")
  echo "Current project: ${current_project}"
  if ! type gcloud &>/dev/null; then
    echo "gcloud not found" >&2
    return 1
  fi
  local proj=$(gcloud projects list | fzf --height 50% --header-lines=1 --reverse --multi --cycle | awk '{print $1}')
  if [[ -n $proj ]]; then
    gcloud config set project $proj
    return $?
  fi
}

# Change kubernetes context
function kube-context() {
  local current_context=$(kubectl config current-context)
  echo "Current context: ${current_context}"
  if ! type kubectl &>/dev/null; then
    echo "kubectl not found" >&2
    return 1
  fi
  local context=$(kubectl config get-contexts | fzf --height 50% --header-lines=1 --reverse --multi --cycle | awk '{print $1}')
  if [[ -n $context ]]; then
    kubectl config use-context $context
    return $?
  fi
}
