{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./default.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
