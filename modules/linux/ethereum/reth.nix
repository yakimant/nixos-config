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

  services.ethereum.reth.hoodi = {
    enable = true;
    # TODO: switch to nixpkgs and help maintaining
    package = inputs.ethereum-nix.packages.x86_64-linux.reth;
    openFirewall = true;
    # INFO: to upgrade
    #package = inputs.ethereum-nix.packages.x86_64-linux.geth.overrideAttrs (_ : rec {
    #  version = "1.15.3";
    #  src = pkgs.fetchFromGitHub {
    #    owner = "ethereum";
    #    repo = "go-ethereum";
    #    rev = "v${version}";
    #    hash = "sha256-G1xnIF9cF8xrEam/N3Y65odJS0yAf2F0vhtAwHQSfsQ=";
    #  };
    #  vendorHash = "";
    #});

    args = {
      # log =
      chain = "hoodi";
      full = true;
      port = 30303;
      metrics = {
        enable = true;
        port = 6060;
        # addr = metrics-host
      };
      authrpc = {
        port = 8551;
        # jwtsecret = "/data/nimbus-beacon-holesky/jwt-secret";
        jwtsecret = config.age.secrets."service/reth/authrpc-jwt".path;
        # /var/run/reth/jwtsecret
      };
      http = {
        enable = true;
        port = 8545;
        api = [ "eth" "net" ];
      };
      ws.enable = false;
    };
  };
}
