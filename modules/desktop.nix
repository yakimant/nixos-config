{ inputs, pkgs, ... }:

# python, r, ruby ?

let
  firacode = pkgs.nerd-fonts.fira-code;
in
{
  fonts.packages = [ firacode ];

  # INFO: needed for matrix-commander
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  environment.systemPackages = with pkgs; [
      age
      age-plugin-yubikey
ansible-lint
#ansible_2_16
      awscli2
#bitwarden-cli # doesnt compile
      cachix
      cf-terraforming
      cloudflare-cli
      unstable.codex
      colima
#consul
      docker
      doctl
#element-desktop # SSO doesn't work on macOS
      fd
      ffmpeg
      fq
      fswatch
      gimp
      gnupg
      go
      google-clasp
      google-cloud-sdk
      graphviz
      hcloud
      hugo
      innoextract
      matrix-commander
      makefile2graph
      markdownlint-cli
      mdbook
      firacode
      nixos-anywhere
      # nixos-rebuild
      nixos-rebuild-ng
      nodejs_24
      oath-toolkit
      opentofu
      p7zip
      pass
      passage
      pidgin
      pinentry-tty
      pkg-config
      postgresql_16
      qemu_kvm
      qrencode
#qsv
      s3cmd
      s5cmd
      shellcheck
      signal-cli
      terraformer
      tor
      transmission_4
#terraform
#vault
      xq
      yandex-cloud
      yq
      yubikey-manager
      yt-dlp
      zbar
  ];
  # ] ++ (with inputs.ethereum-nix.packages.${pkgs.system}; [
  #   staking-deposit-cli
  # ]);
}
