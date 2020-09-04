#!/usr/bin/env bash

unlink ~/Brewfile
ln -s $(pwd)/Brewfile ~/Brewfile

unlink ~/.vimrc
ln -s $(pwd)/vimrc ~/.vimrc

unlink ~/.gitconfig
ln -s $(pwd)/gitconfig ~/.gitconfig
