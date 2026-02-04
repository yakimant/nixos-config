hosts-domain := "tail39c650.ts.net"
remote-builder-ssh-addr := env('NIX_REMOTE_BUILDER_ADDR', "qnap."+hosts-domain)
remote-builder-ssh-user := env('NIX_REMOTE_BUILDER_USER', 'yakimant')

default:
  @just --list

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

update:
  nix flake update

nixos-anywhere host ip:
  nixos-anywhere --build-on remote --copy-host-keys --flake .#{{ host }} root@{{ ip }}

# TODO: switch to disko-install
# https://github.com/nix-community/disko/issues/947
#sudo disko-install \
#--flake .#{{ host }}  --write-efi-boot-entries \
#--disk main {{ disk }}
disko-install host:
  disko --mode disko --flake .#{{ host }}
  sudo nixos-install --no-channel-copy --no-root-password --flake .#{{ host }}

darwin:
  sudo xcodebuild -license accept
  sudo scutil --set LocalHostName $(scutil --get HostName)
  sudo darwin-rebuild switch --flake .

# FIXME: Doesnt work on macOS, due to yubikey ssh -sk keys. Try on linux.
##nixos-remote host: _check_remote_builder_ssh
#nixos-remote host:
#  nixos-rebuild-ng switch --flake .#{{ host }} \
#  --sudo \
#  --target-host {{ host }} \
#  --builders 'ssh-ng://yakimant@178.63.54.221 x86_64-linux - 2 1 - - -' \
#  --use-substitutes \
#  --no-reexec \
#  --verbose
#  # --max-jobs 0 \
#  # builders = ssh-ng://${NIX_REMOTE_BUILDER_USER:-yakimant}@${NIX_REMOTE_BUILDER_ADDR:-qnap.tail39c650.ts.net} x86_64-linux - ${NIX_REMOTE_BUILDER_CORES:-2} 1 - - -
#
#nixos-remote-dry host: _check_remote_builder_ssh
#  nixos-rebuild dry-activate --flake .#{{ host }} \
#  --use-remote-sudo --target-host {{ host }} \
#  --build-host {{ host }} \
#  --use-substitutes \
#  --max-jobs 0 \
#  --fast

nixos:
  sudo nixos-rebuild switch --flake .

nixos-dry:
  sudo nixos-rebuild dry-activate --flake .

repl:
  nix repl --file repl.nix

agenix-rekey:
  cd secrets && agenix --rekey
