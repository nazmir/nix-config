{ config, pkgs, ... }:

{
  home.username = "mir";
  home.homeDirectory = "/Users/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    #firefox
    git
    #fragments

    #fish
    fish
    fishPlugins.tide
    fishPlugins.fzf-fish
    fishPlugins.grc
    fishPlugins.colored-man-pages

    #fonts
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    source-code-pro
    nerdfonts

    moonlight-qt

    #emacs
    ripgrep-all
    fd
    pandoc
    shellcheck
    nixfmt

  ];
}
