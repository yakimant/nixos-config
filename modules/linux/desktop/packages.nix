{ pkgs, ... }:

# node, python, go, perl, r, ruby ?

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    alacritty
    bitwarden-desktop
    discord
    firefox
    libnotify
    playerctl
    spotify
    telegram-desktop
  ];
}
