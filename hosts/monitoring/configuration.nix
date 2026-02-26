{
  ...
}:

{
  # age.secrets.ssh_host_ed25519_key = {
  #   file = ./secrets/ssh_host_ed25519_key.age;
  #   mode = "0600";
  #   owner = "root";
  #   group = "root";
  # };
  #
  # services.openssh = {
  #   enable = true;
  #   hostKeys = [
  #     { path = config.age.secrets.ssh_host_ed25519_key.path; type = "ed25519"; }
  #   ];
  # };

  imports = [
    # ../../modules/monitoring
    ./disk-config.nix
    ./hardware-configuration.nix
  ];


  # For BIOS/GPT setup
  boot.loader.grub = {
    # Note: It's not necessary to set boot.loader.grub.device here, since Disko will take care of that automatically.
    # devices = [ ];
    # device = "/dev/sda";
    enable = true;
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # efiSupport = true;
    # efiInstallAsRemovable = true;
  };

  boot.zfs.requestEncryptionCredentials = false;

  networking.hostId = "84f2cf61"; # random number, required for ZFS: openssl rand -hex 4

  # host-info.sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII9egst+7SGqB7aQrSg47kVzQbjjofVVbTuhDZENPm0k";

  system.stateVersion = "25.05";
}
