{ pkgs, ... }:

# node, python, go, perl, r, ruby ?

{
  # TODO: needed for matrix-commander
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  environment.systemPackages = with pkgs; [
      age
      age-plugin-yubikey
#ansible-lint
#ansible_2_16
      awscli2
#bitwarden-cli # doesnt compile
      cachix
      cf-terraforming
      colima
#consul
      direnv
      docker
      fd
      fq
      fswatch
      gimp
      gnupg
      go
      hugo
      just
      matrix-commander
      makefile2graph
      mdbook
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      nixos-anywhere
      nixos-rebuild
      pass
      passage
      pidgin
      pkg-config
      postgresql_16
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
