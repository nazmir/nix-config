{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./default.nix
    ./tailscale-service.nix
    ./sunshine.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
