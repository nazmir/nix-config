{ config, pkgs, ... }:

{
  home.username = "mir";
  home.homeDirectory = "/home/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
		firefox
    kitty
    fish
    meslo-lgs-nf
    fishPlugins.tide
    fishPlugins.fzf-fish
    fishPlugins.grc
		fishPlugins.colored-man-pages
		git
		emacs
		vim
	];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
	  MOZ_ENABLE_WAYLAND = 1;
  };

	programs.kitty = {
		enable = true;		
		theme = "Spacemacs";
		
	};

	programs.git = {
		enable = true;
		userEmail = "mirnaz.hussain@gmail.com";
		userName = "Naz Mir";
	};

	programs.fish = {
		enable = true;
		plugins = [
	    { name = "fishplugin-grc-unstable"; src = pkgs.fishPlugins.grc.src; }
		];
	};

	dconf.settings = {
	  "org/virt-manager/virt-manager/connections" = {
    	autoconnect = ["qemu:///system"];
  	  uris = ["qemu:///system"];
	  };
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
