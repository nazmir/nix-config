# Load AMD driver for Xorg and Wayland
#Bootloader and AMD boot module
boot.initrd.kernelModules = [ "amdgpu" ];
services.xserver.videoDrivers = ["amdgpu"];
