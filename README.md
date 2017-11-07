# Installing new machine

## Install textmate first and check the installation paths and change them if not same that in .zshrc

## Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/go/install)"
    brew doctor
    brew install zsh zsh-completions git wget rbenv node

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.githubusercontent.com/harjis/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems
    rbenv install -l
    rbenv global X.X.X
    gem update --system
    gem update
    gem cleanup
    gem install bundler rails
    
## Java
    brew tap caskroom/versions && brew cask install java8
    brew install maven
