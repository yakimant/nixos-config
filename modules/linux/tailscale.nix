{ pkgs, config, secret, ... }:

let
  hostname = config.networking.hostName;
in {
  age.secrets = {
    "service/tailscale/${hostname}" = {
      file = ../../secrets/service/tailscale/${hostname}.age;
    };
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    extraUpFlags = [ "--ssh=false" ];
    extraSetFlags = [ "--ssh=false" ];
    # WARNING: These keys expire after 90 days.
    # https://login.tailscale.com/admin/settings/keys
    authKeyFile = config.age.secrets."service/tailscale/${hostname}".path
  };
}
