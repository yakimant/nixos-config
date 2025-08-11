{ inputs, lib, pkgs, ... }:

{
  imports = [
    ./users.nix
    ./zfs.nix
    ./tailscale.nix
  ];
 
  environment.systemPackages = [
    inputs.agenix.packages.x86_64-linux.default
    # Read-only
    pkgs.apfs-fuse
    # experimantal, enctyption not supported
    # linuxKernel.packages.linux_6_16.apfs
  ];

  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    settings = {
      # TODO: initrd ssh for boot issues
      PermitRootLogin = lib.mkForce "no";
      PasswordAuthentication = false;
    };
  };

  # https://discourse.nixos.org/t/logrotate-config-fails-due-to-missing-group-30000/28501
  services.logrotate.checkConfig = false;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}
