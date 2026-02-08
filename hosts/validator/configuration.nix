{
  ...
}:

{
  imports = [
    ../../modules/linux/ethereum
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  #swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking.hostId = "8df49230"; # random number, required for ZFS: openssl rand -hex 4

  system.stateVersion = "25.05";
}
