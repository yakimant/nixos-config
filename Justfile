BUILD_HOST := 'linux-02.he-eu-hel1.ci.release'

default:
  @just --list

update:
  nix flake update

nixos-anywhere host:
  nixos-anywhere --build-on-remote --flake .#{{ host }} root@{{ host }}

darwin:
  darwin-rebuild switch --flake .

nixos host:
  nixos-rebuild switch --flake .#{{ host }} \
  --fast --build-host {{ host }} \
  --use-remote-sudo --target-host {{ host }}

repl:
  nix repl --file repl.nix
