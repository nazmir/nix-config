{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # Add Modules
      ./sunshine.nix
      #./hyprland.nix
    ];

  #Boot Loader
  boot.loader.systemd-boot.enable = true;  
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.systemd-boot.consoleMode = "max";

  #Boot Options
  boot.initrd.verbose = true;
  boot.kernelParams = [ "quiet" "udev.log_level=0" ];
  boot.consoleLogLevel = 0;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  #Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "mir";

  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #wget
    pciutils
    desktop-file-utils
    virt-manager
    gparted
    git
    firefox
  ];

 # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

 # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

	# Enable Network Manager
  networking.networkmanager.enable = true;
  #This is needed in case of for example servers that rely on network resources as part of the boot process
  systemd.services.NetworkManager-wait-online.enable = false;

  # Firewall and enable SSH 22 port
	networking.firewall = {
     enable = true;
     # allowedTCPPorts = [ 22 ];
  };
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

	# Enable OpenSSH
	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = true;
		};
	};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


 # Allow unfree packages and nix flakes
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };


 #Flatpak, fish and other customization
  services.flatpak.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mir = {
    isNormalUser = true;
    description = "Naz Mir";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "systemd-journal"];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

	# Virtualization Config
  virtualisation.libvirtd.enable = true;

	# nano config
  programs.nano = {
    nanorc = ''
      set tabsize 2
			set linenumbers
    '';
  };

	# Systemd config
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';


  system.stateVersion = "23.05"; # Did you read the comment?

}
