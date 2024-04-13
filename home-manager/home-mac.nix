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

  /* programs.firefox = {
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
 */
  programs.git = {
    enable = true;
    userEmail = "mirnaz.hussain@gmail.com";
    userName = "Naz Mir";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      { name = "fishplugin-grc-unstable"; src = pkgs.fishPlugins.grc.src; }
      {   name = "fishPlugins.tide"; src = pkgs.fishPlugins.tide.src; }
    ];
    interactiveShellInit = ''
      set -gx PATH ~/.config/emacs/bin $PATH
    '';
    shellAliases = {
      #emacs = "~/.config/emacs/bin/doom run";
    };
  };

  programs.emacs = {
  	enable = true;
  	package = pkgs.emacs-gtk;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
  	extraConfig = ''
    	(setq standard-indent 2)
  	'';
  };

  programs.neovim.enable = true;

  #Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
