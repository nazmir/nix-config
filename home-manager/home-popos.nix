{config, pkgs, inputs, ... }:

{

  imports = [
      ./common.nix
      ./services.nix
  ];
  home.packages = with pkgs; [
   virt-manager
   inputs.nixgl.packages.x86_64-linux.nixGLIntel
  ];

  programs.fish = {
   shellAliases = {
      kitty = "nixGLIntel kitty";
   };
  };

}
