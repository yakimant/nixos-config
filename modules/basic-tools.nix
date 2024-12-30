{ pkgs, ... }:

{
  environment.systemPackages = let
    pythonPackages = pkgs.python311.withPackages (
    _: with (pkgs.python311Packages); [
#rpds-py
    ]
    );
  in with pkgs; [
      age
      age-plugin-yubikey
      ansible_2_16
      ansible-lint
      coreutils
      curl
      fastfetch
      fzf
      gawk
      git
      gnumake
      htop
      jq
      just
      neovim
#      ncdu
      nmap
      openssh
#openssl
      passage
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
