ssh-keygen -t ed25519 -C "abcdef@gmail.com"
cat ~/.ssh/id.pub

nix-shell -p git
cd nixos
cp /etc/nixos/hardware-configuration.nix .

sudo mv configuration.nix configuration.nix.orig
sudo mv hardware-configuration.nix hardware-configuration.nix.orig

sudo ln -s ~/nix-config/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/nix-config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

