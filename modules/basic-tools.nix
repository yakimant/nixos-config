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
mtr
iperf
mosh
      btop
      aria2
      curl
      fastfetch
      fzf
      fswatch
      gawk
      git
      gnumake
      htop
      jq
      neovim
#     ncdu # move from linux-tools when mac issues fixed
      nmap
tree
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
      hyperfine
socat
speedtest-cli
inetutils
  ];
}
