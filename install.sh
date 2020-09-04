#!/usr/bin/env bash

unlink ~/Brewfile
ln -s $(pwd)/Brewfile ~/Brewfile

mkdir -p ~/.vim
unlink ~/.vim/vimrc
ln -s $(pwd)/vimrc ~/.vim/vimrc

unlink ~/.gitconfig
ln -s $(pwd)/gitconfig ~/.gitconfig
