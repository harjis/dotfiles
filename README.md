# Installing new machine

## Install textmate and sublime first and check the installation paths and change them if not same that in .zshrc

## Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/go/install)"
    brew doctor
    brew install zsh git hub ssh-copy-id wget rbenv ruby-build rbenv-gem-rehash rbenv-bundler

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.githubusercontent.com/harjis/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems
    rbenv install 2.2.2
    rbenv global 2.2.2
    gem update --system
    gem update
    gem cleanup
    gem install bundler rails

## MariaDB
	brew install mariadb
	unset TMPDIR
	mysql_install_db
	
## After this set root password for mysql
	mysql -uroot
	SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');

## Node.js bower and ember
	brew install node
	npm install -g ember-cli
	npm install -g bower
	brew install watchman
	npm install -g phantomjs