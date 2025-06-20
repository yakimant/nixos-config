{
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.ethereum-nix.nixosModules.default
  ];

  environment.systemPackages = with inputs.ethereum-nix.packages.x86_64-linux; [
    nimbus
    staking-deposit-cli
  ];

  users.users.nimbus-beacon-holesky = {
    group = "nimbus-beacon-holesky";
    home = "/data/nimbus-beacon-holesky";
    uid = 6000;
    description = "nimbus-beacon-holesky service user";
    isSystemUser = true;
    createHome = true;
  };

  users.groups.nimbus-beacon-holesky = {
    gid = 6000;
  };

  networking.firewall = {
    allowedTCPPorts = [ 9000 ];
    allowedUDPPorts = [ 9000 ];
  };

  services.ethereum.nimbus-beacon.holesky = {
    enable = true;
    # TODO: switch to nimbus-eth2 flake
    package = inputs.ethereum-nix.packages.x86_64-linux.nimbus;
    args = {
      data-dir = "/data/nimbus-beacon-holesky";
      trusted-node-url = "http://testing.holesky.beacon-api.nimbus.team";
      el = [ "http://127.0.0.1:8551" ];
      jwt-secret = "/data/nimbus-beacon-holesky/jwt-secret";
      user = "nimbus-beacon-holesky";
      tcp-port = 9000;
      udp-port = 9000;
      metrics = {
        enable = true;
        port = 5054;
      };
      rest = {
        enable = true;
        port = 5052;
      };
      payload-builder = {
        enable = true;
        url = "http://127.0.0.1:18550";
      };
    };
    extraArgs = [
      "--local-block-value-boost=0"
    ];
  };

  systemd.services.nimbus-beacon-holesky.serviceConfig = {
    DynamicUser = lib.mkForce false;
  };
}
