{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
      ncdu
      nmap
      openssh
      openssl
      python311
      ripgrep
      rsync
      tldr
      tmux
      wget
      zsh
  ];
}
