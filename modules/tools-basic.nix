{ pkgs, ... }:

{
  environment.systemPackages = let
    pythonPackages = pkgs.python311.withPackages (
    _: with (pkgs.python311Packages); [
#rpds-py
    ]
    );
  in with pkgs; [
      aria2
      btop
      coreutils
      curl
      fastfetch
      fswatch
      fzf
      gawk
      git
      gnumake
      gnused
      htop
      hyperfine
      inetutils
      iperf
      jq
      mosh
      mtr
#ncdu # move from linux-tools when mac issues fixed
      neovim
      nmap
      openssh
#openssl
      python311
#pythonPackages
      ripgrep
      rsync
      socat
      speedtest-cli
      tldr
      tmux
      tree
      wget
      zsh
  ];
}
