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

    tldr
    nh
  ];

  programs.git = {
    enable = true;
    userEmail = "mirnaz.hussain@gmail.com";
    userName = "Naz Mir";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "simple";
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
