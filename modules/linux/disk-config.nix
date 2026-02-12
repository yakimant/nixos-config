{ config, lib, ... }:

with lib;

let
  cfg = config.customDiskConfig;

  # Default root filesystem options for ZFS
  defaultRootFsOptions = {
    # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zfsprops.7.html
    acltype = "posixacl";
    atime = "off";
    compression = "zstd";
    dnodesize = "auto";
    mountpoint = "none";
    normalization = "formD";
    xattr = "sa";
  };

in {
  options.customDiskConfig = {
    enable = mkEnableOption "custom shared disk configuration";

    # Helper function to create ZFS datasets with common options
    # Exported so hosts can use it
    mkZfsDataSet = mkOption {
      type = types.unspecified;
      default = mountpoint: quota: snapshot: options: mountOptions: {
        type = "zfs_fs";
        inherit mountpoint;
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zfsprops.7.html
        options = {
          inherit quota;
          reservation = quota;
          # Used by services.zfs.autoSnapshot options.
          "com.sun:auto-snapshot" = if snapshot then "true" else "false";
          mountpoint = "legacy";
        } // options;
        # https://man7.org/linux/man-pages/man5/fstab.5.html
        inherit mountOptions;
      };
      readOnly = true;
      description = "Helper function to create ZFS datasets";
    };

    primaryDisk = {
      device = mkOption {
        type = types.str;
        description = "Primary disk device path (e.g., /dev/disk/by-id/...)";
      };

      name = mkOption {
        type = types.str;
        default = "main";
        description = "Name for the primary disk";
      };
    };

    bootPartition = {
      size = mkOption {
        type = types.str;
        default = "1G";
        description = "Size of the boot partition";
      };
    };

    swapSize = mkOption {
      type = types.str;
      default = "8G";
      description = "Size of the swap partition";
    };

    poolName = mkOption {
      type = types.str;
      default = "rpool";
      description = "Name of the ZFS pool";
    };

    ashift = mkOption {
      type = types.str;
      default = "0";
      description = "ZFS ashift value (physical sector size)";
    };

    rootFsOptions = mkOption {
      type = types.attrs;
      default = defaultRootFsOptions;
      description = "Root filesystem options for ZFS";
    };

    reserveSize = mkOption {
      type = types.str;
      default = "10G";
      description = "Size to reserve in the ZFS pool";
    };

    datasets = mkOption {
      type = types.attrs;
      default = {};
      description = "ZFS datasets configuration. Use customDiskConfig.mkZfsDataSet to create datasets.";
    };

    extraDatasets = mkOption {
      type = types.attrs;
      default = {};
      description = "Additional ZFS datasets to add to the pool";
    };

    extraDisks = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          device = mkOption {
            type = types.str;
            description = "Disk device path";
          };
          pool = mkOption {
            type = types.str;
            description = "ZFS pool name for this disk";
          };
        };
      });
      default = {};
      description = "Additional disks to configure";
    };

    extraPools = mkOption {
      type = types.attrs;
      default = {};
      description = "Additional ZFS pools configuration";
    };
  };

  config = mkIf cfg.enable {
    disko.devices = {
      disk = {
        ${cfg.primaryDisk.name} = {
          device = cfg.primaryDisk.device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = cfg.bootPartition.size;
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              zfs = {
                end = "-${cfg.swapSize}";
                content = {
                  type = "zfs";
                  pool = cfg.poolName;
                };
              };
              swap = {
                size = cfg.swapSize;
                content = {
                  type = "swap";
                  randomEncryption = true;
                };
              };
            };
          };
        };
      } // mapAttrs (name: disk: {
        device = disk.device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = disk.pool;
              };
            };
          };
        };
      }) cfg.extraDisks;

      zpool = let
        reserve = cfg.mkZfsDataSet null cfg.reserveSize false {} [];
        reserveDataset = if cfg.reserveSize != "0G" && cfg.reserveSize != "0" && cfg.reserveSize != "" then { inherit reserve; } else {};
      in {
        ${cfg.poolName} = {
          type = "zpool";
          rootFsOptions = cfg.rootFsOptions;
          # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zpoolprops.7.html
          options.ashift = cfg.ashift;
          datasets = cfg.datasets // cfg.extraDatasets // reserveDataset;
        };
      } // cfg.extraPools;
    };
  };
}
