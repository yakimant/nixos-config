{ inputs, lib, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    settings = {
      # need for zfs decrypt
      # dropbear as alternative
      #PermitRootLogin = lib.mkForce "no";
      # give root same keys
      #PasswordAuthentication = false;
    };
  };

  # https://discourse.nixos.org/t/logrotate-config-fails-due-to-missing-group-30000/28501
  services.logrotate.checkConfig = false;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}
