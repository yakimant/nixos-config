{ pkgs, ... }:

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
      colima
#consul
      docker
#element-desktop # SSO doesn't work on macOS
      fd
      ffmpeg
      fq
      fswatch
      gimp
      gnupg
      go
      hugo
      matrix-commander
      makefile2graph
      markdownlint-cli
      mdbook
      firacode
      nixos-anywhere
      nixos-rebuild
      nodejs_24
      pass
      passage
      pidgin
      pkg-config
      postgresql_16
      qemu_kvm
      qrencode
#qsv
      s5cmd
      shellcheck
      signal-cli
      terraformer
      tor
      transmission_4
#terraform
#vault
      xq
      yq
      yt-dlp
      zbar
  ];
}
