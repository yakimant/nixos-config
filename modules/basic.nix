{ lib, pkgs, ... }:

{
  programs.zsh.enable = true;

  services.openssh.enable = true;
}
