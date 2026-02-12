{
  config,
  ...
}:

let
  mkZfsDataSet = config.customDiskConfig.mkZfsDataSet;
in
{
  imports = [
    # ../../modules/monitoring
    # ./disk-config.nix  # Now using shared module
    ./hardware-configuration.nix
  ];

  # Shared disk configuration
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_111211921";
    primaryDisk.name = "disk";
    swapSize = "8G";
    poolName = "rpool";
    reserveSize = "5G";
    datasets = {
      root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
      nix = mkZfsDataSet "/nix" "10G" false {} [ "defaults" ];
      home = mkZfsDataSet "/home" "1G" true {} [ "defaults" ];
    };
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking.hostId = "84f2cf61"; # random number, required for ZFS: openssl rand -hex 4

  system.stateVersion = "25.05";
}
