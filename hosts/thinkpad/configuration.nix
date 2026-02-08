{
  ...
}:

{
  imports = [
    ../../modules/desktop.nix
    ../../modules/linux/desktop
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
    hostId = "0e9a6b56"; # random number, required for ZFS
    networkmanager.enable = true;
    #wireless.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";

  services.pcscd.enable = true; # needed for age-yubikey-plugin #TODO refactor
}
