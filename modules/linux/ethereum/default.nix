{
  inputs,
  lib,
  ...
}:

{
  environment.systemPackages = with inputs.ethereum-nix.packages.x86_64-linux; [
    staking-deposit-cli
  ];

  imports = [
    ./nimbus-beacon-node.nix
    ./reth.nix
    # ./mev-boost.nix
  ];
}
