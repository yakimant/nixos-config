{
  modulesPath,
  lib,
  pkgs,
  inputs,
  ...
}:

{
#  imports =
#    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#    ];
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.yakimant = {
    isNormalUser = true;
    description = "yakimant";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoGVex1+pNWNMwC5dygX0WnYcythWB76c5s+M68JKsETiTNeJRbRqB5vMiaeeb0uTXdwNeic5inJkF4VDkW53o2v2+c5HbizgXB3VlxdZJDaK3eK6QfQ4QfUsvphdh5BgFTCvCj0u2Jja+lupsNg68jQirTDTyKo8nrWbYnWGGgjMDLUZ3iO3XmjGEH82izfyg4IWGum4+58hPwTfqn+sO1M6mEUgwgtgUmXPXk5W2xlrzVVNtfpUU1rCLjpdIP8dStFUczm9u9M1hYAGhH9XuqYY4L1bKyHhb20hKlujItudLxN6H7iNy3tOLFvpNRib9euhoqRKMuROtucANKRoA6HM7JvpBykbWuEHDmxWsy2CCGxaNJbsexkEqzCiULBLIxBL2KSFX0rp4BZ9VqrfwPTcl60Mh0DbRDzGAAiEnHRk9Mjz/L1enGk7Gtqso2uyi6pi7b9r/1znkKJUfSRALRMdcnm6wghSvNA/WHKCDxwKY31DUw7kKZXeyjZbbQ/8U1+84jleT8xMdAECz/lhVD2jQ5rrD8hchziXjvKcUT4lzXW8gZ5LwXLC4AJC7Wvq/Hue1HKJDTMCx82uWRPCLhO+ZbUnorsdvkFhoVN7A5QeQIWp8C6xZPGEPej/4v9l/iB2bKv6v7TTlnJrCM6CSRP2XhblsvXaGo+tjEHaKxw== yakimant@gmail.com"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoGVex1+pNWNMwC5dygX0WnYcythWB76c5s+M68JKsETiTNeJRbRqB5vMiaeeb0uTXdwNeic5inJkF4VDkW53o2v2+c5HbizgXB3VlxdZJDaK3eK6QfQ4QfUsvphdh5BgFTCvCj0u2Jja+lupsNg68jQirTDTyKo8nrWbYnWGGgjMDLUZ3iO3XmjGEH82izfyg4IWGum4+58hPwTfqn+sO1M6mEUgwgtgUmXPXk5W2xlrzVVNtfpUU1rCLjpdIP8dStFUczm9u9M1hYAGhH9XuqYY4L1bKyHhb20hKlujItudLxN6H7iNy3tOLFvpNRib9euhoqRKMuROtucANKRoA6HM7JvpBykbWuEHDmxWsy2CCGxaNJbsexkEqzCiULBLIxBL2KSFX0rp4BZ9VqrfwPTcl60Mh0DbRDzGAAiEnHRk9Mjz/L1enGk7Gtqso2uyi6pi7b9r/1znkKJUfSRALRMdcnm6wghSvNA/WHKCDxwKY31DUw7kKZXeyjZbbQ/8U1+84jleT8xMdAECz/lhVD2jQ5rrD8hchziXjvKcUT4lzXW8gZ5LwXLC4AJC7Wvq/Hue1HKJDTMCx82uWRPCLhO+ZbUnorsdvkFhoVN7A5QeQIWp8C6xZPGEPej/4v9l/iB2bKv6v7TTlnJrCM6CSRP2XhblsvXaGo+tjEHaKxw== yakimant@gmail.com"
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # random number, required for ZFS
  networking.hostId = "4d57ec25";

  system.stateVersion = "24.05";

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "yakimant" ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}
