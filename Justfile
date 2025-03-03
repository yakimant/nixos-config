BUILD_HOST := 'linux-02.he-eu-hel1.ci.release'

default:
  @just --list

update:
  nix flake update

nixos-anywhere host:
  nixos-anywhere --build-on-remote --flake .#{{ host }} root@{{ host }}

disko-install host: #disk:
  # https://github.com/nix-community/disko/issues/947
  #sudo disko-install \
  #--flake .#{{ host }}  --write-efi-boot-entries \
  #--disk main {{ disk }}
  sudo disko --mode disko --flake .#{{ host }}
  sudo nixos-install --no-channel-copy --no-root-password --flake .#{{ host }}

darwin:
  darwin-rebuild switch --flake .

nixos-remote host:
  nixos-rebuild switch --flake .#{{ host }} \
  --fast --build-host {{ host }} \
  --use-remote-sudo --target-host {{ host }}

nixos:
  sudo nixos-rebuild switch --flake .

# TODO: cleanup/enable experiments
#nixos1 host:
#  nixos-rebuild dry-build --flake .#{{ host }} \
#  --fast --build-host {{ host }} \
#  --use-remote-sudo --target-host {{ host }}
#
#nixos2 host:
#  nixos-rebuild dry-activate --flake .#{{ host }} \
#  --fast --build-host {{ host }} \
#  --use-remote-sudo --target-host {{ host }}
#
#nixos3 host:
#  nixos-rebuild dry-activate --flake .#{{ host }} \
#  --fast --build-host {{ BUILD_HOST }} \
#  --use-remote-sudo --target-host {{ host }}.yakimant.io
#
#nixos4 host:
#  nixos-rebuild build -v --flake .#{{ host }} \
#  --fast --build-host {{ BUILD_HOST }} \
#  --use-remote-sudo --target-host {{ host }}.yakimant.io

repl:
  nix repl --file repl.nix
