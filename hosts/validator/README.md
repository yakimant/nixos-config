TODO:

- eth hoodi setup
  - [ ] reth: jwt secret
  - [ ] reth: disable file log
  - [ ] nimbus: jwt secret
- [ ] reth/nimbus data dir
- [ ] agenix for secrets (jwt, validator key) https://nix-community.github.io/nixos-anywhere/howtos/secrets.html
- [ ] setup date sync (timedatectl?)
- [ ] fix reboot - ZFS issue

Prepare host config:

1. List device ids:

```
ls /dev/disk/by-id/nvme-*
```

2. Hardware condig:

```
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-shell -p nixos-install-tools
```

3. Should not have ssh keys
https://github.com/nix-community/nixos-anywhere/issues/436

4. get ssh key, rekey secrets

Setup:

1. just nixos-anywhere
2. looks like trusted node sync doesnt work, run manualy
2. jwt-secret: `openssl rand -hex 32`
