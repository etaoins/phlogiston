#!/bin/sh

set -eu

# Don't prompt for package configuration
export DEBIAN_FRONTEND=noninteractive

# Update and install base packages
apt-get update
apt-get full-upgrade -y
apt-get install -y mosh curl sudo git vim llvm-8 lldb-8 libc6-dbg \
  build-essential libz-dev fish docker.io

# We were cloned over HTTPS; make us read/write once we have a private key
git remote set-url origin git@github.com:etaoins/phlogiston.git

# Use Vim as root's editor
update-alternatives --set editor /usr/bin/vim.basic

# Add a `ryan` user using Fish shell and no password
adduser --shell /usr/bin/fish --disabled-password --gecos "Ryan Cumming" ryan
usermod -a -G docker ryan

# Allow `ryan` to sudo without a password because he doesn't have one
echo 'ryan ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-ryan

# `rust-lldb` expects `lldb` without the version suffix
update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-8 100

# Make a copy of ourselves in `ryan`'s home directory
USER_SELF_COPY=~ryan/Code/phlogiston
mkdir -p $(dirname "${USER_SELF_COPY}")
cp -R . "${USER_SELF_COPY}"
chown -R ryan:ryan $(dirname "${USER_SELF_COPY}")

# Execute `config-dev-user.sh` as `ryan`
su - ryan -s /bin/sh -c "cd ${USER_SELF_COPY} && ./config-dev-user.sh"
