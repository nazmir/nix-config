{config, pkgs, inputs, ... }:

{

  imports = [
      ../common.nix
      ../services.nix
  ];
  home.packages = with pkgs; [
   #inputs.nixgl.packages.x86_64-linux.nixGLIntel
  ];

}
