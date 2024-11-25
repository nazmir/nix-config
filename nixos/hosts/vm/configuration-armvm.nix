{config, pkgs, ...}:
{

  imports = [
    ./hardware-configuration.nix
    ./default.nix
  ];
  #Hostname
  networking.hostName = "mir-nixos-armvm"; # Define your hostname.

}
