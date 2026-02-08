{
  ...
}:

{
  imports = [
    ../../modules/linux/ethereum
    ./disk-config.nix
    # ./hardware-configuration.nix
  ];

  #swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking.hostId = "4d57ec25"; # random number, required for ZFS

  system.stateVersion = "25.05";
}
