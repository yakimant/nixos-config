{
  imports = [
    ./packages.nix
    ./sway.nix
  ];

  programs.ssh.startAgent = true;

  #fonts = {
  #  enableDefaultPackages = true;
  #};
}
