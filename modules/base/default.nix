{
  imports = [
    ./packages.nix
    ./nix.nix
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  networking.search = [
    "yakimant.io"
    "status.im"
    "develp.co"
  ];
}
