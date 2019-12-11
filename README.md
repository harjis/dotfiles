# Installing new machine

## Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew cask install iterm2 textmate

## Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

## [docker](https://hub.docker.com/)

## Java
    brew tap caskroom/versions && brew cask install java8
    brew install maven
