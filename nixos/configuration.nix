{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

			# Add Modules
			./common.nix
#			./nvidia.nix
			./sunshine.nix
    ];

#Boot Loader
  boot.loader.systemd-boot.enable = true;  
	boot.loader.efi.canTouchEfiVariables = true;

#Mount Windows file system
	boot.supportedFilesystems = [ "ntfs" ];
	fileSystems."/mnt/2TB" = { 
		device = "/dev/disk/by-label/windows";
    fsType = "ntfs-3g"; 
    options = [ "rw" "uid=1000"];
  };

#Hostname
  networking.hostName = "mir-nixos-thinkpad"; # Define your hostname.
#	networking.hostName = "mir-nixos-pc"; # Define your hostname.
#	networking.hostName = "mir-nixos-mbp"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;
	services.desktopManager.plasma6.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

	services.xserver.displayManager.sddm = {
		enable = true;
		enableHidpi = true;
		autoNumlock = true;
	};
	
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
			pciutils
			desktop-file-utils 
			neofetch
			htop
			grc
			fzf
			virt-manager
			nvd
			nix-du
			gparted 
			python3
	];
	
  system.stateVersion = "23.05"; # Did you read the comment?

}
