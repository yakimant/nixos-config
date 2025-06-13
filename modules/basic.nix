{
  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      # need for zfs decrypt
      # dropbear as alternative
      #PermitRootLogin = lib.mkForce "no";
      # give root same keys
      #PasswordAuthentication = false;
    };
  };

  users.mutableUsers = false;

  networking.search = [
    "yakimant.io"
    "status.im"
    "develp.co"
  ];
}
