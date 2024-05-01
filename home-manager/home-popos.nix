{config, pkgs, inputs, ... }:

{

  imports = [
      ./common.nix
      ./services.nix
  ];
  home.packages = with pkgs; [
   virt-manager
  ];

}
