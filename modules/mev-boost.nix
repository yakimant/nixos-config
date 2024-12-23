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
    mev-boost
  ];

  services.ethereum.mev-boost.holesky = {
    enable = true;
    package = inputs.ethereum-nix.packages.x86_64-linux.mev-boost;
    args = {
      network = "holesky";
      min-bid = 0.07;
      relay-check = true;
      relays = [
        "https://0xb1559beef7b5ba3127485bbbb090362d9f497ba64e177ee2c8e7db74746306efad687f2cf8574e38d70067d40ef136dc@relay-stag.ultrasound.money"
        "https://0xab78bf8c781c58078c3beb5710c57940874dd96aef2835e7742c866b4c7c0406754376c2c8285a36c630346aa5c5f833@holesky.aestus.live"
        "https://0xafa4c6985aa049fb79dd37010438cfebeb0f2bd42b115b89dd678dab0670c1de38da0c4e9138c9290a398ecd9a0b3110@boost-relay-holesky.flashbots.net"
        "https://0xaa58208899c6105603b74396734a6263cc7d947f444f396a90f7b7d3e65d102aec7e5e5291b27e08d02c50a050825c2f@holesky.titanrelay.xyz"
      ];
    };
  };
}
