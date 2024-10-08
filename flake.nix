{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
          ansible
          bitwarden-cli
          direnv
          fzf
          gnupg
          go
          jq
          neovim
          openssh
          pass
          pinentry_mac
          skhd
          vault
          yabai
      ];

      nixpkgs.config.allowUnfree = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Linux builder to support x86_64-linux
      nix.linux-builder = {
        enable = true;
        # uncomment to have a clean VM
        #ephemeral = true;
        package = pkgs.darwin.linux-builder-x86_64;
        maxJobs = 4;
        config = {
          virtualisation = {
            darwin-builder = {
              diskSize = 40 * 1024;
              memorySize = 8 * 1024;
            };
            cores = 6;
          };
        };
      };
      nix.settings.trusted-users = ["@admin"];

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system = {
        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 4;

        defaults = {
          universalaccess.reduceMotion = true;
          universalaccess.reduceTransparency = true;
        };
      };

      # Install Rosetta 2 to support x86_64-darwin
      # $ softwareupdate --install-rosetta --agree-to-license
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#yakimant-macbook-air
    # But boostrap first with
    # $ nix run nix-darwin -- switch --flake .
    darwinConfigurations."yakimant-macbook-air" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."yakimant-macbook-air".pkgs;
  };
}
