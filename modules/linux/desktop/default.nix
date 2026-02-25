{
  imports = [
    ./packages.nix
    ./sway.nix
    ./keyd.nix
    ./bluetooth.nix
    ./virtualization.nix
  ];

  programs.ssh.startAgent = true;
}
