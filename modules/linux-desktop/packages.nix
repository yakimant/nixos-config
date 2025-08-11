{ pkgs, ... }:

# node, python, go, perl, r, ruby ?

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];
}
