{
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.ethereum-nix.nixosModules.default
  ];

  age.secrets = {
    "service/reth/authrpc-jwt" = {
      file = ../../secrets/service/reth/authrpc-jwt.age;
    };
  };

  services.ethereum.nimbus-beacon.hoodi = {
    enable = true;
    openFirewall = true;
    # TODO: switch to nimbus-eth2 flake
    package = inputs.ethereum-nix.packages.x86_64-linux.nimbus;
    args = {
      network = "hoodi";
      trusted-node-url = "http://testing.hoodi.beacon-api.nimbus.team";
      el = [ "http://127.0.0.1:8551" ];
      jwt-secret = config.age.secrets."service/reth/authrpc-jwt".path;
      tcp-port = 9000;
      udp-port = 9000;
      metrics = {
        enable = true;
        port = 5054;
        # addr = metrics-host
      };
      rest = {
        enable = false;
        # port = 5052;
      };
      payload-builder = {
        enable = false;
        url = "http://127.0.0.1:18550";
      };
    };
    # extraArgs = [
    #   "--local-block-value-boost=0"
    # ];
  };
}
