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
  };


  fonts.fontconfig.enable = true;
}
