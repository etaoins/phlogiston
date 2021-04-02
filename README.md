# 🔥 Phlogiston 🔥

Pholgiston is a set of configuration scripts and templates for setting up a minimal Rust + Vim development environment.
The majority of the configuration comes from [etaoins/vimrc](https://github.com/etaoins/vimrc) and [etaoins/fish-config](https://github.com/etaoins/fish-config).

All scripts assume they're being run from the root of the repository.
`config-dev-user.sh` should be run as a user to set the user's configuration and install Rust.
`config-dev-machine.sh` should be run as `root` on a Debian/Ubuntu machine to install required packages and configure a `ryan` user.

This can be used with an EC2 user data script:

```shell
#!/bin/sh
git clone https://github.com/etaoins/phlogiston
cd phlogiston
./config-dev-machine.sh

# Set an instance-specific prompt colour
su - ryan -c 'set -u fish_color_cwd "#f42"'

reboot
```

Any secrets such as SSH private keys must be injected separately.

## Supported Systems

The following distributions are known to work:

- Debian Bullseye (slim)
- Ubuntu 20.04 (minimal + EC2 AMI)
- Ubuntu 20.10 (minimal)

`make test` will test `config-dev-machine.sh` in Docker for the above distributions.
There is no automated testing against EC2 but it seems to behave the same as minimal with more preinstalled packages. 
