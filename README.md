## Generate SSH keys on new system to clone files from github. 
Sometimes git is not available on vainlla nixos install, in such cases download the repo and then proceed.
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
home-manager switch --flake /home/mir/nix-config/.#mir@mir-nixos-thinkpad
```

## Fish tide prompt configuration
`tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Sparse --icons='Many icons' --transient=No`
  
## Doom Emacs configuration
Install Doom Emacs and make sure to run
`doom doctor` #To check for any issues

Add doom bin to your fish path 

```
    interactiveShellInit = ''
      set -gx PATH ~/.config/emacs/bin $PATH
    '';

```

#### Install fonts if `doom doctor` gives any warnings.
#### Backup original emacs.d directory so that Doom Emacs is picked as default configuration.

`Doom configuration lives in ~/.config/doom/*.el`

Copy doom configuration files to ~/.nix-config/.config/doom

```
mkdir ~/nix-config/.config/doom
cp ~/.config/doom/* ~/nix-config/.config/doom/
ln -s  ~/nix-config/.config/doom/init.el ~/.config/doom/init.el
ln -s  ~/nix-config/.config/doom/config.el ~/.config/doom/config.el
ln -s  ~/nix-config/.config/doom/packages.el ~/.config/doom/packages.el
```

## Nixos check build difference
Build the result before switching
`sudo nixos-rebuild build --flake /home/mir/nix-config/.#mir-nixos-thinkpad` #The result will be in current folder

To compare current system with build result run
`nvd diff /run/current-system/ ./result/ `
`nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)` #To compare result after switch

nvd uses nix store diff-closure, but with improved reporting. Syntax for nix store diff-closure is:
`nix store diff-closures $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)`


## sway config
```
mkdir ~/.config/sway
ln -s ~/nix-config/.config/sway/config ~/.config/sway/config
```
