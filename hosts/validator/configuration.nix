{
  config,
  ...
}:

let
  mkZfsDataSet = config.customDiskConfig.mkZfsDataSet;
in
{
  imports = [
    ../../modules/linux/ethereum
    # ./disk-config.nix  # Now using shared module
    ./hardware-configuration.nix
  ];

  # Shared disk configuration
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M103312";
    primaryDisk.name = "disk1";
    swapSize = "16G";
    poolName = "rpool";
    reserveSize = "10G";
    datasets = {
      root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
      nix = mkZfsDataSet "/nix" "40G" false {} [ "defaults" ];
      home = mkZfsDataSet "/home" "10G" true {} [ "defaults" ];
    };
    extraDatasets = {
      nimbus-beacon-node = mkZfsDataSet "/var/lib/private/nimbus-beacon-hoodi" "500G" true {} [ "defaults" ];
      geth = mkZfsDataSet "/var/lib/private/reth-hoodi" "500G" true {} [ "defaults" ];
      "secret/nimbus/secrets" = mkZfsDataSet "/var/lib/private/nimbus-beacon-hoodi/secrets" "none" true {
        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
      } [ "noauto" "nofail" ];
      "secret/nimbus/validators" = mkZfsDataSet "/var/lib/private/nimbus-beacon-hoodi/validators" "none" true {
        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
      } [ "noauto" "nofail" ];
    };
    extraDisks = {
      disk2 = {
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M103315";
        pool = "rpool";
      };
    };
  };

  #swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking.hostId = "8df49230"; # random number, required for ZFS: openssl rand -hex 4

  system.stateVersion = "25.05";
}
