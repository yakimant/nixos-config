{
  description = "infra-yakimant";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, disko }:
    let
      stableSystems = ["x86_64-linux"  "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
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
          ];

        shellHook = ''
          exec zsh
        '';
        };
      });

      darwinConfigurations."yakimant-macbook-air" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macbook-air/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };

      nixosConfigurations."holesky" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/holesky/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
      # Expose the package set, including overlays, for convenience.
      #darwinPackages = self.darwinConfigurations."yakimant-macbook-air".pkgs;
    };
}
