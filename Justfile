hosts-domain := "tail39c650.ts.net"
remote-builder-ssh-addr := env('NIX_REMOTE_BUILDER_ADDR', "qnap."+hosts-domain)
remote-builder-ssh-user := env('NIX_REMOTE_BUILDER_USER', 'yakimant')

[private]
_check_remote_builder_ssh:
  #!/usr/bin/env bash
  if [ "{{os()}}" != "linux" ] || [ "{{arch()}}" != "x86_64" ]; then
    sudo ssh {{remote-builder-ssh-user}}@{{remote-builder-ssh-addr}} exit
    if [ $? -ne 0 ]; then
      echo "{{RED}}Can't build, remote builder is not accessible:"
      echo "$ ssh {{remote-builder-ssh-user}}@{{remote-builder-ssh-addr}} exit"
      echo "Set LIDO_REMOTE_USER and LIDO_REMOTE_ADDR to ammend"
      exit 1
    fi
  fi

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

nixos-remote host: _check_remote_builder_ssh
  nixos-rebuild switch --flake .#{{ host }} \
  --use-remote-sudo --target-host {{ host }} \
  --fast \
  --use-substitutes
  #--builders 'ssh://yakimant@{{ host }}.yakimant.io x86_64-linux - 16' \
  #--build-host {{ host }} \
  #--max-jobs 0 \

nixos-remote-dry host: _check_remote_builder_ssh
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
