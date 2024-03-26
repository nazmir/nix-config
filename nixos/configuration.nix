# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  
	boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "mir-nixos-thinkpad"; # Define your hostname.

	#nvidia


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
	
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
	#services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;
	services.xserver.displayManager.defaultSession = "plasmawayland";
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.displayManager.sddm.autoLogin.relogin = false;
	services.xserver.displayManager.sddm.autoNumlock = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.openssh = {
		enable = true;
	};

	#Flatpak
	services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mir = {
    isNormalUser = true;
    description = "Naz Mir";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    shell = pkgs.fish;
    packages = with pkgs; [
      _1password-gui
	  ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 	nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
			mesa-demos
			nvd
			gparted 
			os-prober
			grub2
			python3
			ngrok
			mosh
			plymouth
	];
	
	virtualisation.libvirtd.enable = true;
	programs.dconf.enable = true;
	programs.fish.enable = true;	
	programs.mosh.enable = true;

	programs.nano = {
		nanorc = ''
			set tabsize 2
		'';
	};

	systemd.extraConfig = ''
  	DefaultTimeoutStopSec=10s
	'';



  system.stateVersion = "23.05"; # Did you read the comment?

}
