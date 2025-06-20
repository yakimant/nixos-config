# Qnap

## TODO

- [ ] zfs auto-snapshots test (zfs list -t snapshot)
- [ ] zfs auto-scrap (test, see logs)

- [ ] zfs auto-trim
- [ ] zfs home encryption
- [ ] initrd: network & ssh
- [ ] disable root password, ssh
- [ ] consider RAM upgade (to 8 or 16)
- [ ] consider SWAP for installer

- [ ] try ZFS/SMB integration, see usershare, sharesmb
- [ ] choose shares schema (private/public, etc)

## Setup

1. Set USB boot in BIOS (F2 or DEL)
2. Enter shell: `nix-shell -p git disko`
3. Clone repo: `git clone https://github.com/yakimant/nixos-config.git`
4. Setup NIX
```
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```
5. Remove python temporary from packages (OOM workaroun)
6. Install
```
just disko-install qnap
```
