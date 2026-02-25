{ pkgs, ... }:

{
  # Set kvm-intel, kvm-amd separately
  # boot = {
    # kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
  # };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    qemu-utils
  ];

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";

    qemu = {
      # runAsRoot = true;
      # Saves space, but cant emulate other architectures (ARM, etc)
      package = pkgs.qemu_kvm;
    };
  };

  # Clipboard sharing - requires spice-guest-tools
  services.spice-vdagentd.enable = true;

  users.users.yakimant.extraGroups = [ "libvirtd" "kvm" ];
}
