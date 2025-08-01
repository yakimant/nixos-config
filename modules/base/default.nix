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
      # TODO: Local:
      #"local.arpa"
      #"home.yakimant.io"
      # Public
      "yakimant.io"
      "status.im"
      "develp.co"
      # VPN
      "tail39c650.ts.net"
    ];
  };
}
