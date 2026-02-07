TODO:

Prepare host config:

1. Create a VM

2. Hardware config:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-shell -p nixos-install-tools
nixos-generate-config --dir .
```

Remove fileSystems, swapDevices.

3. Get disk id and put to disk-config

```bash
ls /dev/disk/by-id/
```

Also set ashift.

4. Add ssh key to secrets.nix

```sh
ssh-keyscan -H hostname
```

5. Add tailscale token, rekey

```sh
cd secrets
agenix -e service/tailscale/hostname.age
agenix --rekey
```

6. Add to flake.nix

Setup:

1. just nixos-anywhere
2. looks like trusted node sync doesnt work, run manualy
2. jwt-secret: `openssl rand -hex 32`
