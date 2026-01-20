TODO:

- [ ] disko file: encrypted datasets for keys, swap (build nimbus?)
- [ ] hardware file
- [ ] eth hoodi setup

- [ ] agenix for secrets (jwt, validator key) https://nix-community.github.io/nixos-anywhere/howtos/secrets.html
- [ ] setup date sync (timedatectl?)
- [ ] fix reboot - ZFS issue

Hardware setup:

1. CPU: thermal paste
2. NVME: 2mm + 0.5mm/1mm thermal pads
3. screws M3?
4. remove case fixing to open easier
5. UEFI bootloader

Setup:

1. nixos-anywhere
2. looks like trusted node sync doesnt work, run manualy
2. jwt-secret: `openssl rand -hex 32`
