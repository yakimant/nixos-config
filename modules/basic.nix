{
  programs.zsh.enable = true;

  services.openssh.enable = true;

  users.mutableUsers = false;

  networking.search = [
    "yakimant.io"
    "status.im"
    "develp.co"
  ];
}
