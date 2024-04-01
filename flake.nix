{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-plasma6-pre.url = "github:nix-community/kde2nix";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, /*nixpkgs-plasma6-pre,*/ home-manager, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      mir-nixos-thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
				specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./nixos/configuration.nix ];
      };

			mir-nixos-mbp = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
				specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./nixos/configuration.nix ];
      };

    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "mir@mir-nixos-thinkpad" = home-manager.lib.homeManagerConfiguration {
				#system = "x86_64-linux";        
				pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ 
					./home-manager/home.nix 
				];
      };

			"mir@mir-nixos-mbp" = home-manager.lib.homeManagerConfiguration {
       	#system = "aarch64-linux";
			 	pkgs = nixpkgs.legacyPackages."aarch64-linux"; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ ./home-manager/home.nix ];
      };		
    };
  };
}
