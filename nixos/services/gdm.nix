{config, lib, pkgs, ...}:

{
 systemd.tmpfiles.rules =
    let
      monitorsXML = pkgs.writeText 
        "monitors.xml"
        ''
          <monitors version="2">
            <configuration>
              <layoutmode>physical</layoutmode>
              <logicalmonitor>
                <x>0</x>
                <y>0</y>
                <scale>2</scale>
                <primary>yes</primary>
                <monitor>
                  <monitorspec>
                    <connector>DP-1</connector>
                    <vendor>GSM</vendor>
                    <product>LG HDR 4K</product>
                    <serial>0x000a523b</serial>
                  </monitorspec>
                  <mode>
                    <width>3840</width>
                    <height>2160</height>
                    <rate>59.997</rate>
                  </mode>
                </monitor>
              </logicalmonitor>
            </configuration>
          </monitors>
        '';      
    in
    [
      "L /run/gdm/.config/monitors.xml - - - - ${monitorsXML}"
    ];

}
