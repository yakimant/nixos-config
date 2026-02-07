{
  ...
}:

{
  imports = [
    ../../modules/base
    ../../modules/linux
    # ../../modules/monitoring
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking = {
    hostName = "monitoring";
    hostId = "84f2cf61"; # random number, required for ZFS: openssl rand -hex 4
  };

  system.stateVersion = "25.05";
}
