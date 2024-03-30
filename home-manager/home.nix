{ config, pkgs, ... }:

{
  home.username = "mir";
  home.homeDirectory = "/home/mir";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
#		firefox
    kitty
  	git  
		fragments	
		google-chrome
		pdfarranger

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

		rustdesk
	];

#  home.file.".config/fish/fish_variables".source = ./dotfiles/fish_variables;


  home.sessionVariables = {
	  MOZ_ENABLE_WAYLAND = 1;
  };

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
          (extension "tabliss" "extension@tabliss.io")
#          (extension "umatrix" "uMatrix@raymondhill.net")
#          (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
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
	};

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
			{	name = "fishPlugins.tide"; src = pkgs.fishPlugins.tide.src; }
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

	services.kdeconnect = {
		enable = true;
		indicator = true;
	};

	dconf.settings = {
	  "org/virt-manager/virt-manager/connections" = {
    	autoconnect = ["qemu:///system"];
  	  uris = ["qemu:///system"];
	  };
	};

	#Allow unfree
	nixpkgs.config.allowUnfreePredicate = _: true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
