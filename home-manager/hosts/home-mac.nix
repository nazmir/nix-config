{ config, pkgs, lib, ... }:

{
  
  home.username = "mir";
  home.homeDirectory = "/Users/mir";
  

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    git

    grc
    fzf

    #fonts
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    source-code-pro
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-sans
    nerd-fonts.zed-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
    meslo-lgs-nf
    meslo-lg

    ripgrep
    fd
    pandoc
    shellcheck
    nixfmt-classic
    nixpkgs-fmt


    #sytem utils
    fastfetch
    btop
    tldr
    nh
    nmap

  ];


  home.sessionVariables = {
    FLAKE = "$HOME/dev/nix-config/";
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    NIX_HOME = "$HOME/dev/nix-config";
    NIXPKGS_ALLOW_UNFREE=1;
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew";
    INFOPATH = "/opt/homebrew/share/info";
  };

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
    "$NIX_HOME/bin"
    "$HOME/.nix-profile/bin/"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
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

	# programs.emacs = {
	# 	enable = true;
	# 	package = pkgs.emacs-gtk;
	# 	extraConfig = ''
	# 		(setq standard-indent 2)
	# 	'';
	# };

programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fishplugin-grc-unstable";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "fishPlugins.tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fishPlugins.fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "fishPlugins.colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }

    ];
    interactiveShellInit = ''
      fastfetch
    '';

    shellInitLast = ''
      			if test "$TERM" = "dumb"
        			function fish_prompt
          			echo "\$ "
        			end
        			function fish_right_prompt; end
        			function fish_greeting; end
        			function fish_title; end
      			end
      		'';

    shellAliases = {
      #emacs = "~/.config/emacs/bin/doom run";
      ll = "ls -al";
      "..." = "cd ../..";
      python = "python3";
      pip = "pip3";
    };

    shellAbbrs = {
      gs = "git status";
      ga = "git add .";
      gc = "git commit -m";
      gpull = "git pull origin main";
      gpush = "git push origin main";
      nhos = "nh os switch --ask";
      nhhome = "nh home switch --ask";
      c = "clear";
      ff = "fastfetch";
    };
  };


  fonts.fontconfig.enable = true;
  #Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
