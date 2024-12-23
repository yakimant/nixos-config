TODO:
- [ ] zfs disk encryption
- [ ] zfs auto-snapshots
- [ ] agenix for secrets (jwt, validator key) https://nix-community.github.io/nixos-anywhere/howtos/secrets.html
- [ ] swap volume for nimbus build
- [ ] disko: data volume without partitions
- [ ] setup date sync (timedatectl?)
- [ ] fix reboot - ZFS issue

Setup:
1. nixos-anywhere
2. looks like trusted node sync doesnt work, run manualy
2. jwt-secret: `openssl rand -hex 32`
