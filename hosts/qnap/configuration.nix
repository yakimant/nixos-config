{
  config,
  ...
}:

let
  mkZfsDataSet = config.customDiskConfig.mkZfsDataSet;
in
{
  imports = [
    ../../modules/linux/samba.nix
    # ./disk-config.nix  # Now using shared module
    ./hardware-configuration.nix
  ];

  # Shared disk configuration
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/disk/by-id/nvme-CT500P3PSSD8_24444C3312DE";
    primaryDisk.name = "main";
    swapSize = "4G";
    poolName = "rpool";
    reserveSize = "10G";
    datasets = {
      root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
      nix = mkZfsDataSet "/nix" "40G" false {} [ "defaults" ];
      home = mkZfsDataSet "/home" "10G" true {} [ "defaults" ];
    };
    extraDisks = {
      data1 = {
        device = "/dev/disk/by-id/ata-WDC_WD20EFPX-68C4TN0_WD-WX32D347PFEK";
        pool = "data";
      };
      data2 = {
        device = "/dev/disk/by-id/ata-WDC_WD20EFPX-68C4TN0_WD-WX32D94NUY8L";
        pool = "data";
      };
    };
    extraPools = let
      reserve = mkZfsDataSet null "10G" false {} [];
    in {
      data = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = config.customDiskConfig.rootFsOptions;
        options.ashift = "12"; # 4kB
        datasets = {
          data = mkZfsDataSet "/data" "none" true {
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "prompt";
          } [ "noauto" "nofail" ];
          inherit reserve;
        };
      };
    };
  };

  #swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Podgorica";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostId = "cd38793d"; # random number, required for ZFS
    #networkmanager.enable = true;
    #wireless.enable = true;
  };

  users.users.root = {
    hashedPassword = "$6$uzGSLfdzxPtlPETF$.tMGIcunN5IhRuSX8SW3DHmNQx2Zv93moJfPCAes8zUvmRFWnmTn9etrvB7z/NcVS2RTduJm8/SBVfnXy5pg50";
  };

  boot.zfs.requestEncryptionCredentials = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
