{ lib, pkgs, inputs,... }:

let
  isLinux = pkgs.stdenv.isLinux;
  #isDarwin = pkgs.stdenv.isDarwin;
  pythonWithPackages = pkgs.python313.withPackages (
    _: with (pkgs.python313Packages); [
      pip
      huggingface-hub[hf_xet]
    ]
  );
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
    # uncomment after upgrade
    #ncdu
    neovim
    # https://github.com/NixOS/nixpkgs/pull/408290
    #nerdlog
    nmap
    openssh
    openssl
    # wait for nixpkgs?
    # prettier
    pssh
    # python311
    pythonWithPackages
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
    # remove after upgrade
    ncdu
    parted
  ] ++ (with inputs.disko.packages.${pkgs.system}; [
      disko
      disko-install
  ]);
}
