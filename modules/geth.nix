{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.ethereum-nix.nixosModules.default
  ];

  environment.systemPackages = with inputs.ethereum-nix.packages.x86_64-linux; [
    geth
  ];

  users.users.geth-holesky = {
    group = "geth-holesky";
    home = "/data/geth-holesky";
    uid = 6001;
    description = "geth-holesky service user";
    isSystemUser = true;
    createHome = true;
  };

  users.groups.geth-holesky = {
    gid = 6001;
  };

  networking.firewall = {
    allowedTCPPorts = [ 30303 ];
    allowedUDPPorts = [ 30303 ];
  };

  services.ethereum.geth.holesky = {
    enable = true;
    package = inputs.ethereum-nix.packages.x86_64-linux.geth;
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
      datadir = "/data/geth-holesky";
      network = "holesky";
      syncmode = "snap";
      port = 30303;
      metrics = {
        enable = true;
        port = 6060;
      };
      authrpc = {
        port = 8551;
        jwtsecret = "/data/nimbus-beacon-holesky/jwt-secret";
      };
      http = {
        enable = true;
        port = 8545;
      };
      ws = {
        enable = false;
        port = 8546;
      };
    };
  };

  systemd.services.geth-holesky.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce "geth-holesky";
  };
}
