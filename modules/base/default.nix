{
  imports = [
    ./packages.nix
    ./nix.nix
    ./users.nix
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  users.mutableUsers = false;

  networking.search = [
    "yakimant.io"
    "status.im"
    "develp.co"
  ];
}
