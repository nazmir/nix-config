## Generate SSH keys on new system to clone files from github. 
```sh
ssh-keygen -t ed25519 -C "abcdef@gmail.com"
cat ~/.ssh/id.pub
```

## Rename the configuration and hardware config files as per the host name e.g.
```sh
sudo ~/nix-config/bin/rename-and-link.sh /etc/nixos/configuration.nix ~/nix-config/nixos/configuration-armvm.nix
sudo ~/nix-config/bin/rename-and-link.sh /etc/nixos/hardware-configuration.nix ~/nix-config/nixos/hardware-configuration-armvm.nix
```

## For the first build run nixos rebuild traditionally without flakes
```sh
sudo nixos rebuild switch
# After the first run you can use flakes like this
sudo ~/nix-config/bin/rename-and-link.sh /etc/nixos/configuration.nix ~/nix-config/nixos/configuration-armvm.nix
```



## Enable / Install nix command
Install nix from *determinate systems for non nixos* systems. In case of Nixos enable experimental features - this should already be enabled in configuration.nix

On nixos systems to permanently enable add the following to configuration.nix

``` nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```


## Install Home manager as a standalone using flakes

``` nix
nix run home-manager/master -- init --switch ~/nix-config/home/
```

## Doom Emacs configuration
Install Doom Emacs and make sure to run  
`doom doctor` #To check for any issues

Backup ~/.emacs.d if it exists  

``` sh
mv ~/.emacs.d ~/.emacs.d.orig
```

Copy doom configuration files to ~/.nix-config/.config/doom  

```sh
~/nix-config/bin/rename-and-link.sh ~/.config/doom/ ~/nix-config/.config/doom
```

## sway config
```sh
~/nix-config/bin/rename-and-link ~/.config/sway/config ~/.config/sway/config
```
## Kitty configuration

```sh
~/nix-config/bin/rename-and-link ~/.config/kitty/ ~/nix-config/.config/kitty 
#The result will be in current folder
```


## To update the system
```nix 
nix flake update
```

## Using *`nh`* helper to rebuild system or home manager

``` nix
nh os switch --ask #Ask for confirmation before applying configuration
nh home switch --ask

#To specify flakes explicitly use:
nh os switch --ask ~/nix-config/.#mir-nixos-thinkpad

#To use the current hostname and specify flake path reference use:
nh os switch --ask ~/nix-config/ 
```

## Garbage collection using *`nh`* helper

``` nix
nh clean all #Clean OS and Home profiles
nh clean user #clean user profiles
```

## Cleaning specific profiles 

``` nix
nix profile list
nh clean profile -a nixGL #nixGL is profile name and -a asks for confirmation
```

## Apply config via flakes in case *`nh`* helper is not installed
```nix
sudo nixos-rebuild switch --flake /home/mir/nix-config/.#mir-nixos-thinkpad
home-manager switch --flake /home/mir/nix-config/.#mir@mir-nixos-thinkpad
```
 
## Nixos check build difference if *`nh`* helper is not installed
Build the result before switching  
```sh 
sudo nixos-rebuild build --flake /home/mir/nix-config/.#mir-nixos-thinkpad 
``` 

To compare current system with build result run  
```nix 
nvd diff /run/current-system/ ./result/ 
nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2) #To compare result after switch
```

nvd uses nix store diff-closure, but with improved reporting. Syntax for nix store diff-closure is:  
```nix 
nix store diff-closures $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)
```
