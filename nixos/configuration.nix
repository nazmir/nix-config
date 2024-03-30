# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	boot.plymouth.enable = true;
	boot.consoleLogLevel = 0;


  boot.loader.systemd-boot.enable = true;  
	boot.loader.efi.canTouchEfiVariables = true;

	boot.supportedFilesystems = [ "ntfs" ];
	fileSystems."/mnt/2TB" = { 
		device = "/dev/disk/by-label/windows";
    fsType = "ntfs-3g"; 
    options = [ "rw" "uid=1000"];
  };


  networking.hostName = "mir-nixos-thinkpad"; # Define your hostname.


	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};

	#nvidia Enable opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;  
	};

# Load AMD driver for Xorg and Wayland
# Bootloader and AMD boot module
# boot.initrd.kernelModules = [ "amdgpu" ];
# services.xserver.videoDrivers = ["amdgpu"];

# Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {

	# Modesetting is needed most of the time
  modesetting.enable = true;

	# Enable power management (do not disable this unless you have a reason to).
	# Likely to cause problems on laptops and with screen tearing if disabled.
	powerManagement.enable = true;

	# Use the open source version of the kernel module ("nouveau")
	# Note that this offers much lower performance and does not
	# support all the latest Nvidia GPU features.
	# You most likely don't want this.
	# Only available on driver 515.43.04+
  open = false;

	# Enable the Nvidia settings menu, accessible via `nvidia-settings`.
	nvidiaSettings = true;

	# Optionally, you may need to select the appropriate driver version for your specific GPU.
	package = config.boot.kernelPackages.nvidiaPackages.stable;


	prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
		
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";	
		};
	};

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

#	services.xserver.desktopManager.plasma5.enable = true;
	services.desktopManager.plasma6.enable = true;
#	services.xserver.displayManager.defaultSession = "plasmawayland";
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.05"; # Did you read the comment?

}
