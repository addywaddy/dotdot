#!/usr/bin/env bash

unlink ~/Brewfile 2> /dev/null
ln -s $(pwd)/Brewfile ~/Brewfile

mkdir -p ~/.vim
unlink ~/.vimrc 2> /dev/null
unlink ~/.vim/config 2> /dev/null
ln -s $(pwd)/vim/config ~/.vim/config
ln -s $(pwd)/vim/vimrc ~/.vimrc

unlink ~/.gitconfig 2> /dev/null
ln -s $(pwd)/gitconfig ~/.gitconfig

unlink ~/.slate 2> /dev/null
ln -s $(pwd)/slate ~/.slate

unlink ~/.irbrc 2> /dev/null
ln -s $(pwd)/irbrc ~/.irbrc

unlink ~/.zsh 2> /dev/null
ln -s $(pwd)/zsh ~/.zsh

unlink ~/.zshenv 2> /dev/null
ln -s $(pwd)/zsh/zshenv ~/.zshenv

unlink ~/.zshrc 2> /dev/null
ln -s $(pwd)/zsh/zshrc ~/.zshrc
