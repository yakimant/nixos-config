{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules/basic.nix
    ../../modules/basic-mac.nix
    ../../modules/tools-basic.nix
    ../../modules/tools-mac.nix
    ../../modules/tools-desktop.nix
  ];
}
