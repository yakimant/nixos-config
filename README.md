# NixOS Configuration

## macOS manual

```sh
softwareupdate --install-rosetta --agree-to-license
cp $(nix eval --raw nixpkgs#skhd)/Library/LaunchDaemons/org.nixos.skhd.plist ~/Library/LaunchAgents # and fix the PATH
```

## Installation

```sh
curl -L https://nixos.org/nix/install | sh
nix run nix-darwin -- switch --flake .
```

## Update

```sh
nix flake update
```

## Apply

```sh
darwin-rebuild switch --flake .
```

## Links

- [Darwin Configuration Options](https://daiderd.com/nix-darwin/manual/index.html)
