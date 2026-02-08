{
  description = "infra-yakimant";

  inputs = {
    # See https://github.com/NixOS/nixpkgs/issues/107466
    #nixpkgs-darwin-unstable.follows = "nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "nix-darwin";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    yknotify-rs = {
      url = "github:reo101/yknotify-rs";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
      #inputs.flake-parts.follows = "flake-parts";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # remove backup/restore libs broke nimbus
    ethereum-nix = {
      url = "github:nix-community/ethereum.nix/8f01580481e88e169b7ada56f1500dccd6cefe61";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
  };

  outputs = inputs@{ self,
    agenix,
    disko,
    ethereum-nix,
    mac-app-util,
    nix-darwin,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-unstable,
    ... }:
    let
      hosts = {
        mac-mini    = { platform = "darwin"; };
        macbook-air = { platform = "darwin"; };
        monitoring  = { platform = "nixos";  };
        qnap        = { platform = "nixos";  };
        rock5b      = { platform = "nixos"; system = "aarch64-linux"; };
        thinkpad    = { platform = "nixos";  };
        validator   = { platform = "nixos";  };
      };

      nixosHosts =
        builtins.attrNames (nixpkgs.lib.filterAttrs (_: h: h.platform == "nixos") hosts);

      darwinHosts =
        builtins.attrNames (nixpkgs.lib.filterAttrs (_: h: h.platform == "darwin") hosts);

      stableSystems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs stableSystems;
      pkgsFor = nixpkgs.lib.genAttrs stableSystems (
        system: import nixpkgs { inherit system; config.allowUnfree = true; }
      );

      overlay = final: prev: let
        unstablePkgs = import nixpkgs-unstable { inherit (prev) system; config.allowUnfree = true; };
      in {
        unstable = unstablePkgs;
      };
      # Overlays-module makes "pkgs.unstable" available in configuration.nix
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
    in {
      devShells = forAllSystems (system: let
        pkgs = pkgsFor.${system};
      in {
        default = pkgs.mkShellNoCC {
          shellHook =
            ''
              # source .envrc.nix-config
            '';
          packages = with pkgs.buildPackages; [
            just
            nix-output-monitor
            nixos-anywhere
            nixos-rebuild-ng
            disko.packages.${system}.disko
            disko.packages.${system}.disko-install
          ] ++ lib.optionals (system != "aarch64-darwin") [
            nixos-install-tools
          ];
        };
      });

      nixosConfigurations = builtins.listToAttrs (builtins.map (hostname:
        {
          name = hostname;
          value = nixpkgs.lib.nixosSystem {
            system = hosts.${hostname}.system or "x86_64-linux";
            modules = [
              overlayModule
              ./modules/base
              ./modules/linux/base
              disko.nixosModules.disko
              agenix.nixosModules.default
              ./hosts/${hostname}/configuration.nix
              ({...}: { networking.hostName = hostname; })
            ];

            specialArgs = { inherit inputs; };
          };
        }
      ) nixosHosts);

      darwinConfigurations = builtins.listToAttrs (builtins.map (hostname:
        {
          name = hostname;
          value = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              overlayModule
              ./modules/base
              ./modules/desktop.nix
              ./modules/darwin
              agenix.darwinModules.default
              mac-app-util.darwinModules.default
              ./hosts/${hostname}/configuration.nix
              # ({...}: { networking.hostName = hostname; })
            ];

            specialArgs = { inherit inputs; nixpkgs = nixpkgs-darwin; };
          };
        }
      ) darwinHosts);

      # Expose the package set, including overlays, for convenience.
      #darwinPackages = self.darwinConfigurations."yakimant-macbook-air".pkgs;
    };
}
