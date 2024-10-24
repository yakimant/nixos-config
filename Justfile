default:
  @just --list

nixos-anywhere config host:
  nixos-anywhere --build-on-remote --flake .#{{ config }} root@{{ host }}

darwin-rebuild:
  darwin-rebuild switch --flake .

nixos-rebuild config host:
  nixos-rebuild switch --flake .#{{ config }} \
  --fast --build-host {{ host }} \
  --use-remote-sudo --target-host {{ host }}
