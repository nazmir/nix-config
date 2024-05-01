{config, pkgs, ... }:

{
  imports = [
      ./common.nix
      #./sway.nix
  ];

  home.packages = with pkgs; [
    kitty
    pdfarranger
    moonlight-qt
    gparted
    fractal
    fragments

   #gnome
    gnome-browser-connector
    gnome.gnome-tweaks

  ];

  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "1password-x-password-manager" "{d634138d-c276-4fc8-924b-40a0ea21d284}")
        ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
    };
    profiles = {
      profile_0 = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
        id = 0;               # 0 is the default profile; see also option "isDefault"
        name = "profile_0";   # name as listed in about:profiles
        isDefault = true;     # can be omitted; true if profile ID is 0
        settings = {          # specify profile-specific preferences here; check about:config for options
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        };
      };
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Spacemacs";
    extraConfig = "
      remember_window_size yes
      tab_bar_edge top
      tab_bar_style fade
      background_blur 90
      tab_bar_margin_height 10.0 10.0
    ";
  };
}
