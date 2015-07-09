#!/bin/sh

function precmd {
  printf "\033]0;%s@%s:%s\007" "${USER}" "`hostname -s`" "${PWD/#$HOME/~}"
}

function _current_time() {
  echo $(($(date +%s) / 60 / 60 / 24))
}

function _update_time() {
  echo "UPDATE_TIME=$(_current_time)" > ~/.oh-my-zsh/custom/.joonas-lastupdate
}

if [ ! -f ~/.oh-my-zsh/custom/.joonas-lastupdate ]; then
  _update_time
else
  source ~/.oh-my-zsh/custom/.joonas-lastupdate
  CURRENT_TIME=$(_current_time)
  TIME_DIFF=$(($CURRENT_TIME-$UPDATE_TIME))

  if [ $TIME_DIFF -gt 13 ]; then
    curl --silent -L https://raw.githubusercontent.com/harjis/dotfiles/master/terminal-setup.sh | bash
    _update_time
  fi
fi