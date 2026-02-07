{
  config,
  ...
}:

let
  cfg = config.services.prometheus.exporters.node;
  tsCfg = config.services.tailscale.interfaceName;
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
    #firewallFilter = "-i ${tsCfg.interfaceName} -p tcp -m tcp --dport ${cfg.port}";
    firewallRules = ''
      iifname "${tsCfg.interfaceName}" tcp dport ${cfg.port} counter accept
    '';
  };
}
