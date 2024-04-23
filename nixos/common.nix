{config, pkgs, ...}: {

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
  sound.enable = true;
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


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

}
