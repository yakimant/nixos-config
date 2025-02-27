{ inputs, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
#nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["status" "yakimant" "@admin"];
    substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "no";
    };
  };
}
