export PYENV_ROOT=~/.pyenv
export JAVA_HOME=$(/usr/libexec/java_home)
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go

export PYTHONSTARTUP=$HOME/startup.py

export PATH=/usr/local/sbin:$PATH
export PATH=$HADOOP_PATH/bin:$PATH
export PATH=~/Documents/scripts:$PATH
export PATH=$GOBIN:$PATH
export PATH=/usr/local/opt/scala/idea:$PATH
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=~/.cargo/bin:$PATH
eval "$(pyenv init -)"
