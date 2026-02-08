{
  inputs,
  lib,
  pkgs,
  ...
}:

{
#environment.systemPackages = with pkgs; [
#    netdata
#  ];
#
  services.netdata = {
    enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 19999 ];
  };
}
