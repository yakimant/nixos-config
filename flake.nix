{
  description = "infra-yakimant";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-2311.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-2405.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # See https://github.com/NixOS/nixpkgs/issues/107466
    #nixpkgs-darwin-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ethereum-nix = {
      #url = "github:nix-community/ethereum.nix/";
      url = "github:metacraft-labs/ethereum.nix/3b34218a88c25e2e8801e87875b2572155843f32";
      inputs = {
        nixpkgs.follows = "nixpkgs-2405";
        nixpkgs-2311.follows = "nixpkgs-2311";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-darwin, nix-darwin, disko, ethereum-nix, ... }:
    let
      stableSystems = ["x86_64-linux" "aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs stableSystems;
      pkgsFor = nixpkgs.lib.genAttrs stableSystems (
        system: import nixpkgs { inherit system; config.allowUnfree = true; }
      );
    in {
      devShells = forAllSystems (system: let
        pkgs = pkgsFor.${system};
      in {
        default = pkgs.mkShellNoCC {
          packages = with pkgs.buildPackages; [
            just
            nix-output-monitor
            nixos-anywhere
          ];
        };
      });

      darwinConfigurations."macbook-air" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macbook-air/configuration.nix
        ];
        specialArgs = { inherit inputs; nixpkgs = nixpkgs-darwin; };
      };

      darwinConfigurations."mac-mini" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mac-mini/configuration.nix
        ];
        specialArgs = { inherit inputs; nixpkgs = nixpkgs-darwin; };
      };

      nixosConfigurations."holesky" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
#pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          disko.nixosModules.disko
          ./hosts/holesky/configuration.nix

          # optional: add nixos modules via the default nixosModule
#ethereum-nix.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };

      # Expose the package set, including overlays, for convenience.
      #darwinPackages = self.darwinConfigurations."yakimant-macbook-air".pkgs;
    };
}
