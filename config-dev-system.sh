#!/bin/sh

set -eu

git remote set-url origin git@github.com:etaoins/phlogiston.git

export DEBIAN_FRONTEND=noninteractive

apt update
apt full-upgrade -y
apt install -y mosh git vim llvm-7 build-essential libz-dev fish

update-alternatives --set editor /usr/bin/vim.basic

adduser --shell /usr/bin/fish --disabled-password --gecos "Ryan Cumming" ryan
usermod -a -G admin ryan
echo 'ryan ALL=(ALL) NOPASSWD' >> /etc/sudoers

cp -R . /home/ryan/phlogiston
chown -R ryan:ryan /home/ryan/phlogiston
