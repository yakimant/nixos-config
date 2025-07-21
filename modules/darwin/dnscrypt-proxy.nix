{ lib,... }:

{
  # https://github.com/nix-darwin/nix-darwin/issues/1408
  launchd.daemons.dnscrypt-proxy.serviceConfig.UserName = lib.mkForce "root";

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
      #cloaking_rules
      #random
      #cache

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
