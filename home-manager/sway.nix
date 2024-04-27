{config, pkgs, ... }:

{

    home.packages = with pkgs; [
        sway
        jq
        waybar
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
        sway-launcher-desktop
        xdg-desktop-portal-wlr
        slurp
        seatd
        grim
    ];
}
