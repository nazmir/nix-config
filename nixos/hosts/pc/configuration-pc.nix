{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../default.nix
    ../../services/tailscale-service.nix
    ../../services/sunshine.nix
  ];

  networking.hostName = "mir-nixos-pc";

}
