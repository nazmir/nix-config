{ config, lib, pkgs, ... }:
{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
		nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
