{ lib,... }:

{
  networking = {
    wakeOnLan.enable = true;
    dns = [
      "127.0.0.1"
      # cloudflare-family
      #"1.1.1.3"
      #"1.0.0.3"
    ];
    # TODO: nixos 25.11
    #applicationFirewall.enable = true;
    # networksetup -listallnetworkservices
    knownNetworkServices = [
      "USB 10/100/1000 LAN"
      "Wi-Fi"
      "Ethernet"
    ];
  };

  # https://github.com/nix-darwin/nix-darwin/issues/1408
  launchd.daemons.dnscrypt-proxy.serviceConfig.UserName = lib.mkForce "root";
  users.users._dnscrypt-proxy.home = lib.mkForce "/private/var/lib/dnscrypt-proxy";

  environment.etc."dnscrypt-proxy/forwarding-rules.txt".text = ''
    # lan 192.168.0.1
    *.torproject.org 1.1.1.1
  '';

  environment.etc."dnscrypt-proxy/cloaking-rules.txt".text = ''
  '';

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = ["127.0.0.1:53"];

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = false;

      # TODO
      #bootstrap_resolvers = 
      #doh_servers = true;
      #dnscrypt_servers = true;
      #odoh_servers = false;
      #relays
      #random
      #cache
      # firefox local doh

      forwarding_rules = "/etc/dnscrypt-proxy/forwarding-rules.txt";
      cloaking_rules = "/etc/dnscrypt-proxy/cloaking-rules.txt";

      sources.parental-control = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/parental-control.md"
          "https://download.dnscrypt.info/resolvers-list/v3/parental-control.md"
          "https://cdn.staticaly.com/gh/DNSCrypt/dnscrypt-resolvers/master/v3/parental-control.md"
        ];
        cache_file = "parental-control.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
      };
    };
  };
}
