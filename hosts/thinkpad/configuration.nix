{
  config,
  ...
}:

{
  imports = [
    ../../modules/desktop.nix
    ../../modules/linux/desktop
    # ./disk-config.nix  # Now using shared module
    ./hardware-configuration.nix
  ];

  # Shared disk configuration
  # Note: thinkpad uses a different dataset structure with "local" parent
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/nvme0n1";
    primaryDisk.name = "main";
    swapSize = "16G";
    poolName = "zroot";
    ashift = "12";
    rootFsOptions = {
      # Different from default - no dnodesize and normalization
      acltype = "posixacl";
      atime = "off";
      compression = "zstd";
      mountpoint = "none";
      xattr = "sa";
    };
    # Override datasets with thinkpad-specific hierarchical structure
    datasets = {
      "local" = {
        type = "zfs_fs";
        options.mountpoint = "none";
      };
      "local/home" = {
        type = "zfs_fs";
        mountpoint = "/home";
        options = {
          "com.sun:auto-snapshot" = "true";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          mountpoint = "legacy";
        };
      };
      "local/nix" = {
        type = "zfs_fs";
        mountpoint = "/nix";
        options = {
          "com.sun:auto-snapshot" = "false";
          mountpoint = "legacy";
        };
      };
      "local/root" = {
        type = "zfs_fs";
        mountpoint = "/";
        options = {
          "com.sun:auto-snapshot" = "false";
          mountpoint = "legacy";
        };
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
      };
    };
    # Note: thinkpad doesn't use a reserve dataset
    reserveSize = "0G";
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
    hostId = "0e9a6b56"; # random number, required for ZFS
    networkmanager.enable = true;
    #wireless.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";

  services.pcscd.enable = true; # needed for age-yubikey-plugin #TODO refactor
}
