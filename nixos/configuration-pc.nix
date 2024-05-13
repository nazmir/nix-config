{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration-pc.nix
    ./default.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
