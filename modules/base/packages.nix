{ lib, pkgs, ... }:

let
  isLinux = pkgs.stdenv.isLinux;
  #isDarwin = pkgs.stdenv.isDarwin;
  #pythonPackages = pkgs.python311.withPackages (
  #  _: with (pkgs.python311Packages); [
  #     #rpds-py
  #  ]
  #);
in {
  environment.systemPackages = with pkgs; [
    aria2
    btop
    coreutils
    curl
    direnv
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
    just
    mosh
    mtr
#ncdu # move from linux-tools when mac issues fixed
    neovim
    nmap
    openssh
#openssl
    pssh
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
  ] ++ lib.optionals isLinux [
    lsof
    ncdu # move to above general list when mac issue fixed
    parted
  ];
}
