#!/bin/sh

set -eu

mkdir -p ~/.config
rm -Rf ~/.config/fish || true
git clone https://github.com/etaoins/fish-config.git ~/.config/fish
cd ~/.config/fish
git remote set-url origin git@github.com:etaoins/fish-config.git
cd -
cp local.fish ~/.config/fish

git clone https://github.com/etaoins/vimrc.git ~/.vim
cd ~/.vim
git remote set-url origin git@github.com:etaoins/vimrc.git
cd -

vim +PlugUpdate +qall

git config --global user.name "Ryan Cumming"
git config --global user.email "etaoins@gmail.com"
cp .gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

curl https://sh.rustup.rs -sSf | sh -- -y
PATH=$PATH:~/.cargo/bin

rustup component add rustfmt
rustup component add clippy
cargo install rg

mkdir ~/.ssh
chmod 700 ~/.ssh
cp authorized_keys ~/.ssh

