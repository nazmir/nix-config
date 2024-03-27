## Generate SSH keys on new system to clone files from github. Sometimes git is not available on vainlla nixos install, in such cases download the repo and then proceed.
```
ssh-keygen -t ed25519 -C "abcdef@gmail.com"
cat ~/.ssh/id.pub
```

## Add unstable channel and update the channel
```
nix-channel --list
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update
```

## Install Home Manager system wide, use the unstable channel

Sometimes home manager might not be available after installation, logout and login should make it available.
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

## Backup the original configuration files and link to git configuration files
```
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.orig
sudo mv /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.orig

sudo ln -s ~/nix-config/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/nix-config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
```


## Update the system
`nix flake update`


## Apply config via flakes
Run rebuild, switch upgrade to update the packages. Flakes is enabled in configuration.nix

```
sudo nixos-rebuild switch --flake /home/mir/nix-config/.#mir-nixos-thinkpad
home-manager switch --flake mir@mir-nixos-thinkpad #username@hostname
```
