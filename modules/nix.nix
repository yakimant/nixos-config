{
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix.channel.enable = false;

  # nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = "nix-command flakes";
    # WARN: keep only root
    # https://nix.dev/manual/nix/2.26/command-ref/conf-file#conf-trusted-users
    #trusted-users = ["root"];
    # TODO: move lido configuration to another module
    trusted-substituters = [
      "https://infra-lido.cachix.org"
      "https://cache.nixos.org"
      "https://mcl-public-cache.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "infra-lido.cachix.org-1:NX5g5Ybi4ZwdZJWPmh7JAHntqvtWesyPfAJwcRvyJGw="
      "mcl-public-cache.cachix.org-1:OcUzMeoSAwNEd3YCaEbNjLV5/Gd+U5VFxdN2WGHfpCI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
