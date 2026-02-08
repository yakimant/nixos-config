{ lib, ... }:

{
  # Importing a suspended pool can corrupt it
  boot.zfs.forceImportRoot = lib.mkForce false;
  boot.zfs.forceImportAll = lib.mkForce false;

  # Snapshot daily
  services.zfs.autoSnapshot = {
    enable = true;
    flags = "-k -p --utc";
    monthly = 6;
    weekly = 4;
    daily = 7;
    hourly = 24;
    frequent = 0;
  };

  # Scrub to find errors
  services.zfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
