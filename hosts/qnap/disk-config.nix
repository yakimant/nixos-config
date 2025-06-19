{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        # TODO: /dev/disk/by-id/
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              end = "-4G";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
          };
        };
      };
      data1 = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              content = {
                type = "zfs";
                pool = "data";
              };
            };
          };
        };
      };
      data2 = {
        device = "/dev/sdb";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              content = {
                type = "zfs";
                pool = "data";
              };
            };
          };
        };
      };
    };
    zpool = let
      rootFsOptions = {
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zfsprops.7.html
        acltype = "posixacl";
        atime = "off";
        compression = "zstd";
        dnodesize = "auto";
        mountpoint = "none";
        normalization = "formD";
        xattr = "sa";
        };

      mkZfsDataSet = mountpoint: quota: snapshot: options: mountOptions: {
        type = "zfs_fs";
        inherit mountpoint;
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zfsprops.7.html
        options = {
          inherit quota;
          reservation = quota;
          # Used by services.zfs.autoSnapshot options.
          "com.sun:auto-snapshot" = toString snapshot;
          mountpoint = "legacy";
        } // options;
        # https://man7.org/linux/man-pages/man5/fstab.5.html
        inherit mountOptions;
      };

      reserve = mkZfsDataSet null "10G" false { } []; #canmount = "off"; } [ ];
    in {
      rpool = {
        type = "zpool";
        inherit rootFsOptions;
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zpoolprops.7.html
        # physical sector size: fdisk / lsblk to confirm
        options.ashift = "0"; # auto, but probably 512B

        datasets = {
          # postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
          root     = mkZfsDataSet "/"     "10G" true  { } [ ];
          nix      = mkZfsDataSet "/nix"  "40G" false { } [ ];
          home     = mkZfsDataSet "/home" "10G" true  { } [ ];
          persist  = mkZfsDataSet "/persist"  "1G" true { } [ ];
          inherit reserve;
        };
      };
      data = {
        type = "zpool";
        mode = "mirror";
        inherit rootFsOptions;
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zpoolprops.7.html
        # physical sector size: fdisk / lsblk to confirm
        options.ashift = "12"; # 4kB

        datasets = {
          data     = mkZfsDataSet "/data" "none" true  {
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "prompt";
          } [ "noauto" "nofail" ];
          inherit reserve;
        };
      };
    };
  };
}
