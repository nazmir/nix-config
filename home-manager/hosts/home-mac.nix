{ config, pkgs, lib, ... }:

{
  
  imports = [
    ../common.nix    
  ];

  home.username = "mir";
  home.homeDirectory = "/Users/mir";
  home.stateVersion = "23.05"; # Please read the comment before changing.

}
