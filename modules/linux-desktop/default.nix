{
  imports = [
    ./packages.nix
    ./sway.nix
    ./keyd.nix
  ];

  programs.ssh.startAgent = true;
}
