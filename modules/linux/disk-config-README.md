# Shared Disk Configuration Module

This module provides a shared and extendable disk configuration for all NixOS hosts using disko and ZFS.

## Overview

The `customDiskConfig` module eliminates code duplication by providing a common interface for disk configuration across all hosts while allowing per-host customization.

## Features

- **Shared Configuration**: Common disk layout (ESP boot partition, ZFS pool, swap)
- **Parameterized**: Easy customization of disk device, swap size, pool name, etc.
- **Extendable**: Support for additional disks, datasets, and pools
- **Helper Function**: `mkZfsDataSet` for consistent dataset creation
- **Flexible**: Override any option for special cases

## Basic Usage

```nix
{
  config,
  ...
}:

let
  mkZfsDataSet = config.customDiskConfig.mkZfsDataSet;
in
{
  customDiskConfig = {
    enable = true;
    primaryDisk.device = "/dev/disk/by-id/nvme-YOUR_DISK_ID";
    swapSize = "8G";
    poolName = "rpool";
    
    datasets = {
      root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
      nix = mkZfsDataSet "/nix" "40G" false {} [ "defaults" ];
      home = mkZfsDataSet "/home" "10G" true {} [ "defaults" ];
    };
  };
}
```

## Configuration Options

### Primary Disk

- `enable`: Enable the shared disk configuration (default: `false`)
- `primaryDisk.device`: Device path (e.g., `/dev/disk/by-id/...`)
- `primaryDisk.name`: Disk name in configuration (default: `"main"`)

### Partitions

- `bootPartition.size`: Size of the ESP boot partition (default: `"1G"`)
- `swapSize`: Size of the swap partition (default: `"8G"`)

### ZFS Pool

- `poolName`: Name of the ZFS pool (default: `"rpool"`)
- `ashift`: ZFS ashift value for sector size (default: `"0"` for auto)
- `rootFsOptions`: Root filesystem options (default includes compression, atime, etc.)
- `reserveSize`: Reserved space in pool (default: `"10G"`, use `"0G"` to disable)

### Datasets

- `datasets`: Main ZFS datasets configuration
- `extraDatasets`: Additional datasets to add to the main pool

### Helper Function

The `mkZfsDataSet` helper function creates ZFS datasets with consistent options:

```nix
mkZfsDataSet = mountpoint: quota: snapshot: options: mountOptions:
```

Parameters:
- `mountpoint`: Mount point path (e.g., `"/"`, `"/home"`) or `null` for no mount
- `quota`: Quota and reservation size (e.g., `"10G"`, `"none"`)
- `snapshot`: Enable auto-snapshot (`true`/`false`)
- `options`: Additional ZFS options (e.g., `{ encryption = "aes-256-gcm"; }`)
- `mountOptions`: Mount options list (e.g., `[ "defaults" ]`, `[ "noauto" "nofail" ]`)

### Advanced Options

- `extraDisks`: Additional disks to configure (for multi-disk setups)
- `extraPools`: Additional ZFS pools (for separate data pools)

## Examples

### Simple Single Disk Setup (monitoring)

```nix
customDiskConfig = {
  enable = true;
  primaryDisk.device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_111211921";
  primaryDisk.name = "disk";
  swapSize = "8G";
  datasets = {
    root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
    nix = mkZfsDataSet "/nix" "10G" false {} [ "defaults" ];
    home = mkZfsDataSet "/home" "1G" true {} [ "defaults" ];
  };
};
```

### With Extra Datasets (rock5b, validator)

```nix
customDiskConfig = {
  enable = true;
  primaryDisk.device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_2TB_...";
  swapSize = "16G";
  datasets = {
    root = mkZfsDataSet "/" "10G" true {} [ "defaults" ];
    nix = mkZfsDataSet "/nix" "40G" false {} [ "defaults" ];
    home = mkZfsDataSet "/home" "10G" true {} [ "defaults" ];
  };
  extraDatasets = {
    # Service-specific datasets
    nimbus-beacon-node = mkZfsDataSet "/var/lib/private/nimbus-beacon-node" "500M" true {} [ "defaults" ];
    geth = mkZfsDataSet "/var/lib/private/geth" "500M" true {} [ "defaults" ];
    
    # Encrypted datasets
    "secret/nimbus/secrets" = mkZfsDataSet "/var/lib/private/nimbus-beacon-node/secrets" "none" true {
      encryption = "aes-256-gcm";
      keyformat = "passphrase";
      keylocation = "prompt";
    } [ "noauto" "nofail" ];
  };
};
```

### Multiple Disks (validator)

```nix
customDiskConfig = {
  enable = true;
  primaryDisk.device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M103312";
  primaryDisk.name = "disk1";
  swapSize = "16G";
  datasets = { /* ... */ };
  extraDisks = {
    disk2 = {
      device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M103315";
      pool = "rpool";  # Add to same pool
    };
  };
};
```

### Multiple Pools with Mirror (qnap)

```nix
customDiskConfig = {
  enable = true;
  primaryDisk.device = "/dev/disk/by-id/nvme-CT500P3PSSD8_...";
  swapSize = "4G";
  datasets = { /* ... */ };
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
      options.ashift = "12";
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
```

### Custom Dataset Hierarchy (thinkpad)

For special cases with hierarchical datasets:

```nix
customDiskConfig = {
  enable = true;
  primaryDisk.device = "/dev/nvme0n1";
  swapSize = "16G";
  poolName = "zroot";
  
  # Override rootFsOptions for specific requirements
  rootFsOptions = {
    acltype = "posixacl";
    atime = "off";
    compression = "zstd";
    mountpoint = "none";
    xattr = "sa";
    # Note: no dnodesize or normalization
  };
  
  # Custom hierarchical dataset structure
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
  
  reserveSize = "0G";  # No reserve dataset
};
```

## Migration from Old disk-config.nix

1. Add to host's `configuration.nix`:
   ```nix
   {
     config,
     ...
   }:

   let
     mkZfsDataSet = config.customDiskConfig.mkZfsDataSet;
   in
   ```

2. Move disk configuration under `customDiskConfig = { enable = true; ... }`

3. Convert datasets to use `mkZfsDataSet` helper

4. Remove `./disk-config.nix` from imports

5. Delete the old `disk-config.nix` file

## Benefits

- **Reduced Duplication**: Common code is shared across all hosts
- **Easier Maintenance**: Update the shared module once, all hosts benefit
- **Consistent Defaults**: Standard options with ability to override
- **Type Safety**: NixOS module system validates configuration
- **Documentation**: Self-documenting with option descriptions
- **Flexibility**: Easy to add host-specific datasets or pools

## See Also

- [disko documentation](https://github.com/nix-community/disko)
- [ZFS on NixOS](https://nixos.wiki/wiki/ZFS)
- [ZFS properties](https://openzfs.github.io/openzfs-docs/man/v2.3/7/zfsprops.7.html)
