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
    # ./hardware-configuration.nix
  ];

  # Shared disk configuration
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_2TB_S7DNNU0Y619285Z";
    primaryDisk.name = "main";
    swapSize = "16G";
    poolName = "rpool";
    reserveSize = "10G";
    datasets = {
      root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
      nix = mkZfsDataSet "/nix" "40G" false {} [ "defaults" ];
      home = mkZfsDataSet "/home" "10G" true {} [ "defaults" ];
    };
    extraDatasets = {
      nimbus-beacon-node = mkZfsDataSet "/var/lib/private/nimbus-beacon-node" "500M" true {} [ "defaults" ];
      geth = mkZfsDataSet "/var/lib/private/geth" "500M" true {} [ "defaults" ];
      "secret/nimbus/secrets" = mkZfsDataSet "/var/lib/private/nimbus-beacon-node/secrets" "none" true {
        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
      } [ "noauto" "nofail" ];
      "secret/nimbus/validators" = mkZfsDataSet "/var/lib/private/nimbus-beacon-node/validators" "none" true {
        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
      } [ "noauto" "nofail" ];
    };
  };

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
