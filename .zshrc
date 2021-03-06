export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/harjukallio/.dotnet/tools"

# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
ZSH_THEME="robbyrussell"

# for oh-my-zsh
plugins=(git zsh-syntax-highlighting)
export ZSH="/Users/harjukallio/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
autoload -U promptinit; promptinit
prompt pure

# Mac
if [[ `uname` == 'Darwin' ]]; then
  # editor
  export EDITOR='mate -w'

  # for ssh-agent (ssh-add -K ~/.ssh/id_rsa)
  eval $(ssh-agent) > /dev/null

  # for homebrew
  alias bu='brew update && brew upgrade && brew cleanup && brew doctor'
  
  alias psql-start='docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres'
  alias psql-stop='docker stop pg-docker'
  alias psql-client='docker exec -it pg-docker psql -U postgres'
  
  alias mssql-start='docker run --rm --name ms-docker -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=verystrongPassword123" \
   -p 1433:1433 -h ms-docker \
   -v sqlvolume:/var/opt/mssql \
   -d mcr.microsoft.com/mssql/server:2019-latest'
  alias mssql-stop='docker stop ms-docker'
  alias mssql-client='docker exec -it ms-docker /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "verystrongPassword123"'

  alias mongo-start='brew services start mongodb'
  alias mongo-stop='brew services stop mongodb'
  
  alias minikube-start='minikube start --cpus 4 --memory 15000 --disk-size 40000mb'
  
  local pc_path="/Users/harjukallio/Sites/relex/planning-cloud"
  local pc_back_path="$pc_path/backend"
  local pc_front_path="$pc_path/frontend"
  local h_path="/Users/harjukallio/Sites/relex/heimdall"
  local h_front_path="$h_path/frontend"
  
  # for misc
  alias l='ls -la'
  alias nano='mate'
  alias netlisteners='lsof -i -P | grep LISTEN'
  alias lc='cd $pc_path && echo https://gitlab.relexsolutions.com/DevHEL/planning-cloud/commit/$(git log -1 --pretty=%h) | pbcopy'
  alias hc='cd $h_path && echo https://gitlab.relexsolutions.com/cat/heimdall/heimdall/commit/$(git log -1 --pretty=%h) | pbcopy'

  alias p='cd $pc_back_path'
  alias pr='cd $pc_front_path'
  alias pflow='cd $pc_front_path && npm run flow'
  alias h='cd $h_path'
  alias hr='cd $h_front_path'
  alias hstart='cd $h_path && ./gradlew bootRun'
  alias hflow='cd $h_front_path && npm run flow'
  
  alias npm-check='npm-check -c -s -u'
  alias npm-global='npm list -g --depth 0'
  alias yarn-check='yarn-check -s -u'
  
  alias dpfv='docker system prune -f --volumes'
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

function grr {
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

# direnv needs to be quite bottom too
eval "$(direnv hook zsh)"

# asdf: These need to be at the bottom of rc-file
. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/harjukallio/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/harjukallio/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/harjukallio/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/harjukallio/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ ! -s /Users/harjukallio/.travis/travis.sh ] || source /Users/harjukallio/.travis/travis.sh
