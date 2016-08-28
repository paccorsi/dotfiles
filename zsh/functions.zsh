font_test() {
    echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
}

# -------------------------------------------------------------------
# compressed file expander
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
ex() {
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
function psax() {
  ps auxwwwh | grep "$@" | grep -v grep
}

# console
script_console() {
    if [ -f config/environment.rb ] && which pry >/dev/null; then
        pry -r./config/environment.rb
    elif [ -x script/rails ]; then
        script/rails console
    elif [ -x script/console ]; then
        script/console
    elif [ -f app.rb ]; then
        local repl=$(which pry >/dev/null && echo pry || echo irb)
        local args=$([ -n "$BUNDLE_GEMFILE" -o -f Gemfile ] && echo "-rbundler/setup")
        $repl $args -I. -r./app.rb
    else
        echo "no script/rails or script/console found" >&2
        return 1
    fi
 }

# server
script_server() {
    if [ -x script/rails ]; then
        script/rails server "$@"
    elif [ -x script/server ]; then
        script/server "$@"
    else
        echo "no script/rails or script/server found" >&2
        return 1
    fi
}

# Reset audio
audioreset() {
    ps aux | grep coreaudio[d] | awk '{print $2}' | xargs sudo kill
}

# Open gem inside vim
bo() {
    local gem_path=`bundle show "$1"`
    vim +":cd $gem_path"
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
    (brew update && brew doctor && brew upgrade)
    brew list > ~/.brew_list
    pip2 install -U $(pip2 list --outdated | awk '{printf $1" "}')
    pip3 install -U $(pip3 list --outdated | awk '{printf $1" "}')
    gem update
    (cd ~/.oh-my-zsh && git checkout master && git pull)
}

# make a backup of a file
bk() {
    cp -a "$1" "${1}_$(date +%s)"
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

# urlencode text
urlencode() {
    ruby -r cgi -e 'puts CGI.escape(ARGV[0])' "$1"
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

# open a web browser on google for a query
google() {
    xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`"
}

# print a separator banner, as wide as the terminal
hr() {
    print ${(l:COLUMNS::=:)}
}

tar_dir() {
    tar -zcvf $1.tar.gz $1
}

decrypt() {
    openssl aes-256-cbc -d -a -in $1 -out $1.new
}

encrypt() {
    openssl aes-256-cbc -a -salt -in $1 -out $1.enc
}

console_tab() {
    osascript &>/dev/null <<EOF
        tell application "iTerm"
            tell current terminal
            launch session "Default Session"
            tell the last session
        end tell
EOF
}

console_split() {
    osascript &>/dev/null <<EOF
        tell application "iTerm"
            tell current terminal
            tell application "System Events" to keystroke "k" using command down
            delay 1
            tell the current session to write text "$@"
        end tell
    end tell
EOF
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
