{config, pkgs, inputs, ... }:

{

  home.username = "mir";
  home.homeDirectory = "/home/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    #firefox
    #kitty
    git
    #fragments
    #google-chrome
    #pdfarranger
    #moonlight-qt
    #fractal
    #gparted
    #virt-manager

    #fish
    fish
    fishPlugins.tide
    fishPlugins.fzf-fish
    fishPlugins.grc
    fishPlugins.colored-man-pages
    grc
    fzf

    #fonts
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    source-code-pro
    terminus-nerdfont
    nerdfonts

    ripgrep
    fd
    pandoc
    shellcheck
    nixfmt

    #gnome
    #gnome-browser-connector
    #gnome.gnome-tweaks

    #sytem utils
    nh
    nvd
    nix-du
    fastfetch
    btop
    htop
    killall

    #Haskell
    haskell-language-server
    haskellPackages.hoogle
    haskellPackages.cabal-install

    #Python
    python3
    isort

    #Clojure
    clojure
    clj-kondo
    leiningen

    #LISP
    sbcl

    inputs.nix-gl-host.defaultPackage.x86_64-linux
  ];

#  home.file.".config/fish/fish_variables".source = ./dotfiles/fish_variable

  home.sessionVariables = {
    FLAKE = "/home/mir/nix-config/";
  };

  # programs.firefox = {
  #   enable = true;
  #   policies = {
  #     ExtensionSettings = with builtins;
  #       let extension = shortId: uuid: {
  #         name = uuid;
  #         value = {
  #           install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
  #           installation_mode = "normal_installed";
  #         };
  #       };
  #       in listToAttrs [
  #         (extension "ublock-origin" "uBlock0@raymondhill.net")
  #         (extension "1password-x-password-manager" "{d634138d-c276-4fc8-924b-40a0ea21d284}")
  #       ];
  #       # To add additional extensions, find it on addons.mozilla.org, find
  #       # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
  #       # Then, download the XPI by filling it in to the install_url template, unzip it,
  #       # run `jq .browser_specific_settings.gecko.id manifest.json` or
  #       # `jq .applications.gecko.id manifest.json` to get the UUID
  #   };
  #   profiles = {
  #     profile_0 = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
  #       id = 0;               # 0 is the default profile; see also option "isDefault"
  #       name = "profile_0";   # name as listed in about:profiles
  #       isDefault = true;     # can be omitted; true if profile ID is 0
  #       settings = {          # specify profile-specific preferences here; check about:config for options
  #         "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
  #         "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  #         "browser.shell.checkDefaultBrowser" = false;
  #         "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  #       };
  #     };
  #   };
  # };

  # programs.kitty = {
  #   enable = true;
  #   theme = "Spacemacs";
  #   extraConfig = "
  #     remember_window_size yes
  #     tab_bar_edge top
  #     tab_bar_style fade
  #     background_blur 90
  #     tab_bar_margin_height 10.0 10.0
  #   ";
  # };

  programs.git = {
    enable = true;
    userEmail = "mirnaz.hussain@gmail.com";
    userName = "Naz Mir";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };

  programs.neovim.enable = true;
  
  programs.fish = {
    enable = true;
    plugins = [
      { name = "fishplugin-grc-unstable"; src = pkgs.fishPlugins.grc.src; }
      {   name = "fishPlugins.tide"; src = pkgs.fishPlugins.tide.src; }
    ];
    interactiveShellInit = ''
      set -gx PATH ~/.config/emacs/bin $PATH
      fastfetch
      set --global --export FONTCONFIG_FILE ${pkgs.fontconfig.out}/etc/fonts/fonts.conf
    '';
    shellAliases = {
      #emacs = "~/.config/emacs/bin/doom run";
      ll = "ls -al";
      "..." = "cd ../..";
    };
  };

  fonts.fontconfig.enable = true;

  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };

  #Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
