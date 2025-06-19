# Qnap

## Setup

1. Set USB boot in BIOS (F2 or DEL)
2. Enter shell: `nix-shell -p git`
3. Clone repo: `git clone https://github.com/yakimant/nixos-config.git`
4. echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
