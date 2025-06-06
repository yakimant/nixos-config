{
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix.channel.enable = false;

  # nix.package = pkgs.nix;
 
  nix.extraOptions =
    ''
      warn-dirty = false
    '';

  nix.settings = {
    experimental-features = "nix-command flakes";
    # WARN: keep only root
    # https://nix.dev/manual/nix/2.26/command-ref/conf-file#conf-trusted-users
    #trusted-users = ["root"];
    # but I need it for per-project remote builders
    trusted-users = ["root" "yakimant" "status"];
    # TODO: move lido configuration to another module
    trusted-substituters = [
      "https://infra-lido.cachix.org"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "infra-lido.cachix.org-1:NX5g5Ybi4ZwdZJWPmh7JAHntqvtWesyPfAJwcRvyJGw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
