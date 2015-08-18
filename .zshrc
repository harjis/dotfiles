# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export JRUBY_OPTS="-J-XX:MaxDirectMemorySize=4G -J-Xmx8G -J-XX:+TieredCompilation"
export CLASSPATH=/Users/harjukallio/Sites/processor-edge/kernel/processor-standard/target/processor-standard-3.7.jar

# for rbenv
if [[ -d "${HOME}/.rbenv/bin" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  alias rbenv-pull='cd ~/.rbenv && git pull && cd ~/.rbenv/plugins/ruby-build && git pull && cd ~/.rbenv/plugins/rbenv-gem-rehash && git pull && cd'
fi

if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

MATE="/Applications/TextMate.app/Contents/SharedSupport/Support/bin/mate"
MATE_BIN="/usr/local/bin/mate"

SUBL="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
SUBL_BIN="/usr/local/bin/subl"

if [[ -f "${SUBL}" && ! -f "${SUBL_BIN}" ]]; then
  ln -s "${SUBL}" "${SUBL_BIN}"
fi

if [[ -f "${MATE}" && ! -f "${MATE_BIN}" ]]; then
  ln -s "${MATE}" "${MATE_BIN}"
fi

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joonas-two"
plugins=(heroku zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Mac
if [[ `uname` == 'Darwin' ]]; then
  # editor
  export EDITOR=subl

  # for ssh-agent (ssh-add -K ~/.ssh/id_rsa)
  eval $(ssh-agent) > /dev/null

  # for homebrew/pear
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH
  alias bu='brew update && brew upgrade --all && brew cleanup && brew doctor'
  alias gu='for ruby in $(rbenv versions --bare); do rbenv shell ${ruby} && echo "Updating Ruby ${ruby}.." && gem update --system -N; gem update -N && gem cleanup; unset RBENV_VERSION; echo; done;'

  # for apache
  alias apache-start='sudo apachectl start'
  alias apache-stop='sudo apachectl stop'
  alias apache-restart='sudo apachectl restart'

  # for mysql/maria
  alias mysql-start='mysql.server start'
  alias mysql-stop='mysql.server stop'

  # for postgres
  alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

  # for misc
  alias l='ls -la'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias nano='mate'
  alias netlisteners='lsof -i -P | grep LISTEN'

  # for rails
  alias migrate='echo "Development..." && bundle exec rake db:migrate RAILS_ENV=development && echo "Test..." && bundle exec rake db:migrate RAILS_ENV=test'

  # for redis
  alias redis-start='redis-server /usr/local/etc/redis.conf'
  alias redis-stop='kill $(cat /usr/local/var/run/redis.pid)'
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  # editor
  export EDITOR=nano
  alias mate='nano'
  alias subl='nano'

  # for printers
  alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'
fi

# generate password
alias gp='openssl rand -base64 21'
alias secret='ruby -e "require \"securerandom\"; puts SecureRandom.hex(64)"'

# misc
alias pgrep='pgrep -lf'
alias e=$EDITOR

# git
alias g='git'
alias git-cleanup='find ~ -path "*/.git" -not -path "*/vendor/bundle/*" -type d -exec sh -c "cd {} && cd .. && git config --get remote.origin.url &> /dev/null && pwd && git fetch origin && git remote prune origin && git gc && if [ -f Gemfile ]; then bundle --quiet && bundle clean; fi && cd && echo" \;'

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}