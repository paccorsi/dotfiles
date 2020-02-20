export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PYENV_ROOT=~/.pyenv
export JAVA_HOME=$(/usr/libexec/java_home)
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/src

export PYTHONSTARTUP=$HOME/startup.py

export PATH="/usr/local/bin:$PATH"
export PATH=/usr/local/sbin:$PATH
export PATH=$HADOOP_PATH/bin:$PATH
export PATH=~/Documents/scripts:$PATH
export PATH="$GOPATH:$GOBIN:$PATH"
export PATH=/usr/local/opt/scala/idea:$PATH
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=~/.cargo/bin:$PATH

PATH="/usr/local/opt/ncurses/bin:$PATH"
# For compilers to find ncurses
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"
export PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig"
