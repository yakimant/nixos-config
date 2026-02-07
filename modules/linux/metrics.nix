{
  config,
  ...
}:

let
  cfg = config.services.prometheus.exporters.node;
  vpnInterfaceName = config.services.tailscale.interfaceName;
in {
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    # enabledCollectors = [
    #   "logind"
    #   "systemd"
    # ];
    disabledCollectors = [ "textfile" ];
    openFirewall = true;
    # iptables:
    #firewallFilter = "-i ${vpnInterfaceName} -p tcp -m tcp --dport ${toString cfg.port}";
    firewallRules = ''
      iifname "${vpnInterfaceName}" tcp dport ${toString cfg.port} counter accept
    '';
  };
}
