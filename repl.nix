rec {
  flake = builtins.getFlake (builtins.toString ./.);
  pkgs = import flake.inputs.nixpkgs {};
  lib = pkgs.lib;
  self = ./.;
  dirs = {
    hosts = "${self}/hosts";
  };
  system = builtins.currentSystem;
  inherit (flake.outputs) nixosConfigurations;
  inherit (flake.outputs) darwinConfigurations;
}
