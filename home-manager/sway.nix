{config, pkgs, ... }:

{
    home.packages = with pkgs; [
        #sway
        jq
        waybar
        blueman
        brightnessctl
        dmenu
        light
        lm_sensors
        mako
        nwg-bar
        nwg-wrapper
        pavucontrol
        swaybg
        swayidle
        swaylock
        swayr
        waybar
        wl-clipboard
        wofi
        papirus-icon-theme
        arc-theme
    ];
}
