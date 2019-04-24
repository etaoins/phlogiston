#!/bin/sh

set -eu

# We were cloned over HTTPS; make us read/write once we have a private key
git remote set-url origin git@github.com:etaoins/phlogiston.git

# Don't prompt for package configuration
export DEBIAN_FRONTEND=noninteractive

# Update and install base packages
apt update
apt full-upgrade -y
apt install -y mosh git vim llvm-7 build-essential libz-dev fish

# Use Vim as root's editor
update-alternatives --set editor /usr/bin/vim.basic

# Add a `ryan` user using Fish shell and no password
adduser --shell /usr/bin/fish --disabled-password --gecos "Ryan Cumming" ryan
usermod -a -G admin ryan

# Allow `ryan` to sudo without a password because he doesn't have one
echo 'ryan ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-ryan

# Make a copy of ourselves in `ryan`'s home directory
USER_SELF_COPY=~ryan/Code/phlogiston
mkdir -p $(dirname "${USER_SELF_COPY}")
cp -R . "${USER_SELF_COPY}"
chown -R ryan:ryan $(dirname "${USER_SELF_COPY}")

# Execute `config-dev-user.sh` as `ryan`
su - ryan -s /bin/sh -c "cd ${USER_SELF_COPY} && ./config-dev-user.sh"
