# 🔥 Phlogiston 🔥

Pholgiston is a set of configuration scripts and templates for setting up a minimal Rust + Vim development environment.
The majority of the configuration comes from [etaoins/vimrc](https://github.com/etaoins/vimrc) and [etaoins/fish-config](https://github.com/etaoins/fish-config).

All scripts assume they're being run from the root of the repository.
`config-dev-user.sh` should be run as a user to set the user's configuration and install Rust.
`config-dev-machine.sh` should be run as `root` on an Ubuntu machine to install required packages and configure a `ryan` user.

This could be used with an EC2 user data script such as the following:

```shell
#!/bin/sh
git clone https://github.com/etaoins/phlogiston
cd phlogiston
./config-dev-machine.sh
reboot
```

Any secrets such as SSH private keys must be injected separately.
