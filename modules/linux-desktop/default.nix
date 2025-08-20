{
  imports = [
    ./packages.nix
    ./sway.nix
    ./keyd.nix
    ./bluetooth.nix
  ];

  programs.ssh.startAgent = true;
}
