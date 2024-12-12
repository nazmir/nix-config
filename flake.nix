{
  description = "Your new nix config";

  inputs = {
    # Nixpkgspkgs.nixVersions.unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

  };

  outputs = { nixpkgs, home-manager, nixos-cosmic, lanzaboote, vscode-server, ... }@inputs:

    {


      nixosConfigurations = {

        mir-nixos-thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = [ ./nixos/hosts/thinkpad/configuration-thinkpad.nix ];
        };

        mir-nixos-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            vscode-server.nixosModules.default
            
            ./nixos/hosts/pc/configuration-pc.nix 
          ];
        };

        mir-nixos-armvm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/hosts/vm/configuration-armvm.nix ];
        };

      };

      homeConfigurations = {
        "mir@mir-nixos-thinkpad"  = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            ./home-manager/hosts/home-nixos.nix
          ];
        };

        "mir@mir-nixos-pc"  = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            ./home-manager/hosts/home-nixos.nix
          ];
        };

        "mir@mir-popos-thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            ./home-manager/hosts/home-popos.nix
          ];
        };


        "mir@mir-mbp14" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [ ./home-manager/hosts/home-mac.nix ];
        };

        "mir@mir-nixos-armvm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-linux"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [ ./home-manager/hosts/home-armvm.nix ];
        };

      };
    };
}
