{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lsof
    ncdu # move to basic-tools when mac issue fixed
    parted
  ];
}
