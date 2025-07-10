{
  imports = [
    ./packages.nix
    ./nix.nix
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  networking = {
    #domain = ""
    search = [
      "yakimant.io"
      "status.im"
      "develp.co"
    ];
  };
}
