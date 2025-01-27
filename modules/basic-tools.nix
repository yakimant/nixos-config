{ pkgs, ... }:

{
  environment.systemPackages = let
    pythonPackages = pkgs.python311.withPackages (
    _: with (pkgs.python311Packages); [
#rpds-py
    ]
    );
  in with pkgs; [
            #      coreutils
      curl
      fastfetch
      fzf
      gawk
      git
      gnumake
      htop
      jq
      neovim
#     ncdu # move from linux-tools when mac issues fixed
      nmap
      openssh
#openssl
      python311
#pythonPackages
      ripgrep
      rsync
      tldr
      tmux
      wget
      zsh
  ];
}
