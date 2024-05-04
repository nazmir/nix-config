{config, pkgs, inputs, ... }:

{

  home.username = "mir";
  home.homeDirectory = "/home/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    git
    virt-manager
    kitty

    #fish
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


    #sytem utils
    nh
    nvd
    nix-du
    fastfetch
    btop
    htop
    killall
    tldr

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

  ];


  home.sessionVariables = {
    FLAKE = "/home/$USER/nix-config/";
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    NIX_HOME = "/home/$USER/nix-config";
    NIXPKGS_ALLOW_UNFREE=1;
    MOZ_USE_XINPUT2=1;
  };

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
    "$NIX_HOME/bin"
  ];

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

  programs.neovim.enable = true;
  
  programs.bash = {
    enable =true;

  };

  programs.fish = {
   enable = true;
    plugins = [
      {name = "fishplugin-grc-unstable"; src = pkgs.fishPlugins.grc.src;}
      {name = "fishPlugins.tide"; src = pkgs.fishPlugins.tide.src;}
      {name = "fishPlugins.fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src;}
      {name = "fishPlugins.colored-man-pages"; src= pkgs.fishPlugins.colored-man-pages.src;}

    ];
    interactiveShellInit = ''
      fastfetch
    '';
    shellAliases = {
      #emacs = "~/.config/emacs/bin/doom run";
      ll = "ls -al";
      "..." = "cd ../..";
    };
  };


  fonts.fontconfig.enable = true;
  #Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
