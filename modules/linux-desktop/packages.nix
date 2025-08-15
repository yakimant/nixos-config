{ pkgs, ... }:

# node, python, go, perl, r, ruby ?

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    alacritty
    firefox
    spotify
    telegram-desktop
  ];
}
