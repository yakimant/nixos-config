# NixOS Configuration

## Installation

```sh
curl -L https://nixos.org/nix/install | sh
nix run nix-darwin -- switch --flake .
```

## Apply

```sh
darwin-rebuild switch --flake .
```

## Links

- [Darwin Configuration Options](https://daiderd.com/nix-darwin/manual/index.html)
