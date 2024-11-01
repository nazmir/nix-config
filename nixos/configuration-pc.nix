{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./default.nix
    ./sunshine.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
