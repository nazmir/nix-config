{config, pkgs, ...}: {

	boot.kernelModules = [ "uinput" ];
  users.groups.input.members = [ "mir" ];
	

	environment.systemPackages = with pkgs; [
    sunshine
  ];

  services.udev.extraRules = ''
		# Needed for sunshine streaming
		KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

	services.avahi = {
		enable = true;
		publish = { enable = true; };
	};

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 47984 47989 48010 ];
		allowedUDPPorts = [ 47998 47999 48000 48002 48010 ];		
	};

	security.wrappers.sunshine = {
		owner = "root";
		group = "root";
		capabilities = "cap_sys_admin+p";
		source = "${pkgs.sunshine}/bin/sunshine";
	};
	
	systemd.user.services.sunshine = {
		description = "sunshine";
 		wantedBy = [ "graphical-session.target" ];
		enable = true;
		serviceConfig = {
			ExecStart = "${config.security.wrapperDir}/sunshine";
		};
	};

}
