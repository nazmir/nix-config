## Generate SSH keys on new system to clone files from github. 
```sh
ssh-keygen -t ed25519 -C "abcdef@gmail.com"
cat ~/.ssh/id_ed25519.pub
```
Add the key to git repo.

## Clone the git repository 
```sh
nix shell --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#git
git clone git@github.com:nazmir/nix-config.git
```
## Create Machine specific and architecture-specific configuration files if needed.
Use the existing confifuration files or create new ones as needed.

## Link the newly renamed configuration files to the nix-config directory
The script will backup the files in source directory (arg1) and link to target directory.  
Don't rename hardware config to specific machine as configuration.nix

```sh
sudo ~/nix-config/bin/rename-and-link.sh /etc/nixos/configuration.nix ~/nix-config/nixos/hosts/pc/configuration-pc.nix
sudo ~/nix-config/bin/rename-and-link.sh /etc/nixos/hardware-configuration.nix ~/nix-config/nixos/hosts/pc/hardware-configuration.nix
sudo nixos-rebuild switch --flake /home/mir/nix-config/.#mir-nixos-pc
```

## Install Home manager as a standalone using flakes
Before installing home manager run nix flake update and then link the config file to git repo

``` nix
cd ~/nix-config
nix flake update

#this will initialize home manager and place config file in ~/.config/home-manager/home.nix 
nix run home-manager/master -- init --switch  
  
~/nix-config/bin/rename-and-link.sh ~/.config/home-manager/home.nix ~/nix-config/home-manager/home-armvm.nix  
  
#initial evaluation with flakes  
home-manager switch --flake /home/mir/nix-config/home-manager/.#mir@mir-nixos-thinkpad 
```

## To update the system
```nix 
nix flake update
```

## Using *`nh`* helper to rebuild system or home manager

``` nix
nh os switch --ask #Ask for confirmation before applying configuration
nh home switch --ask
#home-manager switch --flake '.#mir@mir-nixos-pc'
nh home switch -c mir@mir-nixos-pc ./

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

# Other Package configuration

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

