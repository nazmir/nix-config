{ config, pkgs, ... }:

{
  imports = [
    ./default.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
