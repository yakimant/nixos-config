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
    ansible
    aria2
    btop
    coreutils
    curl
    direnv
    fastfetch
    unstable.foundry
    fswatch
    fzf
    gawk
    gh
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
    # https://github.com/NixOS/nixpkgs/pull/408290
    #nerdlog
    nmap
    openssh
    openssl
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
