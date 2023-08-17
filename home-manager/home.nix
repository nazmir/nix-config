{ config, pkgs, ... }:

{
  home.username = "mir";
  home.homeDirectory = "/home/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
		firefox
    kitty
  	git  
	
		#fish
		fish
    fishPlugins.tide
    fishPlugins.fzf-fish
    fishPlugins.grc
		fishPlugins.colored-man-pages
				
		#editors
		micro

		#fonts
    meslo-lgs-nf
		fira-code
    fira-code-symbols
    source-code-pro

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

 	programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

	programs.neovim.enable = true;

	dconf.settings = {
	  "org/virt-manager/virt-manager/connections" = {
    	autoconnect = ["qemu:///system"];
  	  uris = ["qemu:///system"];
	  };
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
