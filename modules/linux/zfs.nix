{ lib, ... }:

{
  # Importing a suspended pool can corrupt it
  boot.zfs.forceImportRoot = lib.mkForce false;
  boot.zfs.forceImportAll = lib.mkForce false;

  # Snapshot daily
  services.zfs.autoSnapshot = {
    enable = true;
    flags = "-k -p --utc";
    monthly = 0;
    weekly = 2;
    daily = 6;
    hourly = 0;
    frequent = 0;
  };

  # Scrub to find errors
  services.zfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
