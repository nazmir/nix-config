{config, pkgs, ...}:
{

  imports = [
    ./hardware-configuration-armvm.nix
    ./default.nix
  ];
  #Hostname
  networking.hostName = "mir-nixos-armvm"; # Define your hostname.

}
