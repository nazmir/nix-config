{config, pkgs, inputs, ... }:

{

  imports = [
      ./common.nix
  ];

  home.username = "mir";
  home.homeDirectory = "/home/mir";
  home.stateVersion = "23.05"; # Please read the comment before changing.
  
  home.packages = with pkgs; [
   
    #sytem utils
    nvd
    nix-du
    killall
    ethtool

    #lang utils
    nixd
    nil
    vscode
    emacs-all-the-icons-fonts
    windsurf

    #system utils
    gcompris
    alacritty
  ];

}
