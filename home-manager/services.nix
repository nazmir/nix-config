{config, pkgs, ...}:

{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
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
