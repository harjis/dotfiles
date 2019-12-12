# Installing new machine

## Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew cask install iterm2 textmate

## Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

## [Git](https://help.github.com/en/enterprise/2.17/user/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent): 
    brew install git
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    eval "$(ssh-agent -s)"

## [Iterm dracula](https://draculatheme.com/iterm/)

## [pure](https://github.com/sindresorhus/pure)

## [asdf](https://asdf-vm.com/#/core-manage-asdf-vm): 
    brew install asdf
    echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
    echo -e "\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash" >> ~/.zshrc
    brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc unzip curl gpg

## asdf: nodejs
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

## yarn
    brew install yarn

## asdf: ruby
    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

## jenv
    brew install jenv
    jenv enable-plugin export
    exec $SHELL -l
    
    Remember to put things in .zshrc
    
    brew tap homebrew/cask-versions
    brew cask install homebrew/cask-versions/adoptopenjdk8
    brew cask install homebrew/cask-versions/java11
    
## asdf: java NOT WORKING
    brew install jq
    asdf plugin-add java
    asdf install java adopt-openjdk-8u232-b09
    asdf install java adopt-openjdk-11.0.2+9
    asdf global java adopt-openjdk-11.0.2+9
    

## [docker](https://hub.docker.com/)
