eval "$(rbenv init -)"
# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8
export JRUBY_OPTS="-J-XX:MaxDirectMemorySize=2G -J-Xmx4G -J-XX:+TieredCompilation"
export CLASSPATH="../kernel/processor-core/target/classes:../kernel/processor-standard/target/*"
export PATH=./bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

MATE="/Applications/TextMate.app/Contents/SharedSupport/Support/bin/mate"
MATE_BIN="/usr/local/bin/mate"

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
  export EDITOR='mate -w'

  # for ssh-agent (ssh-add -K ~/.ssh/id_rsa)
  eval $(ssh-agent) > /dev/null

  # for homebrew
  alias bu='brew update && brew upgrade && brew cleanup && brew doctor'

  # for apache
  alias apache-start='sudo apachectl start'
  alias apache-stop='sudo apachectl stop'
  alias apache-restart='sudo apachectl restart'

  # for mysql/maria
  alias mysql-start='mysql.server start'
  alias mysql-stop='mysql.server stop'

  # for misc
  alias l='ls -la'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias nano='mate'
  alias netlisteners='lsof -i -P | grep LISTEN'
  alias lc='cd ~/Sites/processor-edge/ && echo https://gitlab.relexsolutions.com/DevHEL/planning-cloud/commit/$(git log -1 --pretty=%h) | pbcopy'

  alias test_c='cd ~/Sites/processor-edge/backend/ && RAILS_ENV=test script/rails console'
  alias jtest='cd ~/Sites/processor-edge/backend/ && JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006 RAILS_ENV=test script/rails console'
  alias rjtest='cd ~/Sites/processor-edge/backend/ && JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006 RAILS_ENV=test rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 --disable-int-handler --evaluation-timeout 10 --rubymine-protocol-extensions -- script/rails console'
  alias rtest="JRUBY_OPTS='-J-XX:MaxDirectMemorySize=2G -J-Xmx4G -J-XX:+TieredCompilation -X+O' && cd ~/Sites/processor-edge/backend/ && RAILS_ENV=test rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 --disable-int-handler --evaluation-timeout 10 --rubymine-protocol-extensions -- script/rails console"
  alias fastorm='cd ~/Sites/processor-edge/backend/ && bundle exec rake fastorm:compile'
  alias p='cd ~/Sites/processor-edge/backend/'
  alias pr='cd ~/Sites/processor-edge/frontend/'
  alias h='cd ~/Sites/heimdall/'
  alias hr='cd ~/Sites/heimdall/frontend/'
  alias ruitest='cd ~/Sites/processor-edge/frontend/ && npm test'
  alias lint='cd ~/Sites/processor-edge/frontend/ && npm run lint'
  alias flow='cd ~/Sites/processor-edge/frontend/ && npm run flow'
  alias hflow='cd ~/Sites/heimdall/frontend/ && npm run flow'
  alias npm-check='npm-check -c -s -u'
  alias npm-global='npm list -g --depth 0'
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  # editor
  export EDITOR=nano
  alias mate='nano'
fi

# misc
alias pgrep='pgrep -lf'
alias e=$EDITOR

# git
alias g='git'

function gr {
  if [ -z "$1" ]; then
     # display usage if no parameters given
     echo "Usage: gr 2"
  else
    git rebase -i HEAD~"$1"
  fi
}

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

function pack {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: pack <path>"
 else
   tar cvzf ./"$1.tar.gz" $1
fi
}

# Begin definitions for helper for relex
function relex {
    local current_path="$(pwd)"

    while [ ! -x "$current_path/tasks.py" -a "$current_path" != "/" ]; do
        current_path="$(dirname "$current_path")"
    done
    if [ -x "$current_path/tasks.py" ]
        then
        ( exec -a relex "$current_path/tasks.py" "${@:1}" )
        return $?
    else
        echo "Not run within Relex repository or the repository is too old to contain tasks.py"
        return 1
    fi
}
# Someday, add command autocomplete definitions here
# End definitions for helper for relex
