#!/bin/sh

set -eu

# Disable our MOTD. It's very verbose and CPU intensive on Ubuntu.
touch ~/.hushlogin

# Allow logins from trusted private keys
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp authorized_keys ~/.ssh

# Configure Fish shell
mkdir -p ~/.config
rm -Rf ~/.config/fish || true
git clone https://github.com/etaoins/fish-config.git ~/.config/fish
cd ~/.config/fish
git remote set-url origin git@github.com:etaoins/fish-config.git
cd -

# Configure Vim
rm -Rf ~/.vim || true
git clone https://github.com/etaoins/vimrc.git ~/.vim
cd ~/.vim
git remote set-url origin git@github.com:etaoins/vimrc.git
cd -

# Install Vim plugins
vim +PlugUpdate +qall > /dev/null

# Configure Git
git config --global user.name "Ryan Cumming"
git config --global user.email "etaoins@gmail.com"
cp .gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Install Rust and set the `PATH` for both this temporary shell and Fish
curl https://sh.rustup.rs -sSf | sh -s -- -y
PATH=$PATH:~/.cargo/bin
cp local.fish ~/.config/fish

# Add some optional Rust components
rustup component add rustfmt
rustup component add clippy

# Add ripgrep which is needed for Vim's fzf plugin
cargo install ripgrep
