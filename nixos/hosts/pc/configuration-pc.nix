{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../default.nix
    ../../services/tailscale-service.nix
    ../../services/sunshine.nix
    ../../services/gdm.nix
  ];

  networking.hostName = "mir-nixos-pc";
  networking.interfaces = {
    enp7s0.wakeOnLan.enable = true;
    tailscale0.wakeOnLan.enable = true;
  };
}
