default:
  @just --list

update:
  nix flake update

nixos-anywhere host:
  nixos-anywhere --build-on-remote --flake .#{{ host }} root@{{ host }}

# TODO: switch to disko-install
# https://github.com/nix-community/disko/issues/947
#sudo disko-install \
#--flake .#{{ host }}  --write-efi-boot-entries \
#--disk main {{ disk }}
disko-install host:
  sudo disko --mode disko --flake .#{{ host }}
  sudo nixos-install --no-channel-copy --no-root-password --flake .#{{ host }}

darwin:
  sudo darwin-rebuild switch --flake .

# INFO: for remote builders:
# configure https://nix.dev/manual/nix/2.26/command-ref/conf-file#conf-builders
nixos-remote host:
  nixos-rebuild switch --flake .#{{ host }} \
  --use-remote-sudo --target-host {{ host }} \
  --fast \
  --use-substitutes
  #--builders 'ssh://yakimant@{{ host }}.yakimant.io x86_64-linux - 16' \
  #--build-host {{ host }} \
  #--max-jobs 0 \

nixos-remote-dry host:
  nixos-rebuild dry-activate --flake .#{{ host }} \
  --use-remote-sudo --target-host {{ host }} \
  --fast \
  --use-substitutes

nixos:
  sudo nixos-rebuild switch --flake .

nixos-dry:
  sudo nixos-rebuild dry-activate --flake .

repl:
  nix repl --file repl.nix
