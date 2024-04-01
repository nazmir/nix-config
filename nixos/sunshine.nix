{config, pkgs, ...}:

{

	boot.kernelModules = [ "uinput" ];
  users.groups.input.members = [ "mir" ];
	

	environment.systemPackages = with pkgs; [
    sunshine
  ];

  services.udev.extraRules = ''
		sunshine
		KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

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
