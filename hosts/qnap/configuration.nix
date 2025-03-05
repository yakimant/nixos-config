{
  ...
}:

{
  imports = [
    ../../modules/basic.nix
    ../../modules/basic-linux.nix
    ../../modules/nix.nix
    ../../modules/tools-basic.nix
    ../../modules/tools-linux.nix
    ../../modules/users.nix
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

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
    hostName = "qnap";
    hostId = "cd38793d"; # random number, required for ZFS
    #networkmanager.enable = true;
    #wireless.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
