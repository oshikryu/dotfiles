# pick up all of the env setting in .profile
. ~/.profile

export VIRTUALENVWRAPPER_PYTHON_ORIGINAL=$(which python)

# start terminal vim with server
alias svim="vim --servername VIM"

# start tmux with 256 colors
alias tmux="tmux -2"

# veewee for vagrant alias
alias veewee='bundle exec veewee'

# sup for supervisorctl alias
alias sup='supervisorctl'

# use vim editing in bash
set -o vi     

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/ryuta/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11%252B28/OpenJDK11-jdk_x64_mac_hotspot_11_28.tar.gz/jdk-11+28/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/ryuta/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
