{config, pkgs, ...}: {
#nvidia Enable opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;  
  };

# Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {

	  # Modesetting is needed most of the time
	  modesetting.enable = true;

	  # Enable power management (do not disable this unless you have a reason to).
	  # Likely to cause problems on laptops and with screen tearing if disabled.
	  powerManagement.enable = true;
		powerManagement.finegrained = false;

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
  		# sync.enable = true;
	    intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";  
    };
	};
}