{config, lib, pkgs, ...}:

{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };

    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer" "xwayland-native-scaling"];
    };
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
    socketActivation.enable = true;
    defaultEditor = true;
  };


  fonts.fontconfig.enable = true;
}
