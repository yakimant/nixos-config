{
  disko.devices = {
    disk = {
      disk = {
        device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_111211921";
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
              end = "-8G";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
                randomEncryption = true;
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
          "com.sun:auto-snapshot" = if snapshot then "true" else "false";
          mountpoint = "legacy";
        } // options;
        # https://man7.org/linux/man-pages/man5/fstab.5.html
        inherit mountOptions;
      };

      reserve = mkZfsDataSet null "5G" false { } []; #canmount = "off"; } [ ];
    in {
      rpool = {
        type = "zpool";
        inherit rootFsOptions;
        # https://openzfs.github.io/openzfs-docs/man/v2.3/7/zpoolprops.7.html
        # physical sector size: `sudo fdisk -l` to confirm
        options.ashift = "0"; # auto, but probably 512B

        datasets = {
          # postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
          root     = mkZfsDataSet "/"         "10G" true  { } [ "defaults" ];
          nix      = mkZfsDataSet "/nix"      "10G" false { } [ "defaults" ];
          home     = mkZfsDataSet "/home"     "1G" true  { } [ "defaults" ];
          # persist  = mkZfsDataSet "/persist"  "1G"  true  { } [ "defaults" ];

          inherit reserve;
        };
      };
    };
  };
}
