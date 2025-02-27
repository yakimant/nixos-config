{
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/basic.nix
    ../../modules/tools-basic.nix
    ../../modules/tools-linux.nix
    ../../modules/nimbus-beacon.nix
    ../../modules/geth.nix
    ../../modules/mev-boost.nix
    ../../modules/nix.nix
    ../../modules/users.nix
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  #swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  networking = {
    hostName = "holesky";
    hostId = "4d57ec25"; # random number, required for ZFS
  };

  system.stateVersion = "24.05";
}
