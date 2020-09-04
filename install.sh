#!/usr/bin/env bash

unlink ~/Brewfile 2> /dev/null
ln -s $(pwd)/Brewfile ~/Brewfile

mkdir -p ~/.vim
unlink ~/.vim/vimrc 2> /dev/null
ln -s $(pwd)/vimrc ~/.vim/vimrc

unlink ~/.gitconfig 2> /dev/null
ln -s $(pwd)/gitconfig ~/.gitconfig

unlink ~/.zsh 2> /dev/null
ln -s $(pwd)/zsh ~/.zsh

unlink ~/.zshrc 2> /dev/null
ln -s $(pwd)/zsh/zshrc.zsh ~/.zshrc
