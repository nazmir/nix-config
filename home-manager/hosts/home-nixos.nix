{config, pkgs, ... }:

{
  imports = [
      ../common.nix
      ../services.nix
  ];

  home.packages = with pkgs; [
    pdfarranger
    moonlight-qt
    gparted
    fractal
    fragments
    virt-manager
    kitty
    cosmic-wallpapers
    #gnome
    gnome-browser-connector
    gnome-tweaks

  ];

  programs.kitty = {
    enable = true;
    themeFile = "adwaita_dark";
    extraConfig = "
      remember_window_size yes
      tab_bar_edge top
      tab_bar_style fade
      background_blur 90
      tab_bar_margin_height 10.0 10.0
    ";
  };
}
