{ inputs, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      ansible
      bitwarden-cli
      cachix
      cf-terraforming
      colima
      coreutils
      direnv
      docker
      fswatch
      fzf
      gawk
      gnumake
      gnupg
      go
      htop
      jq
      just
      makefile2graph
      neovim
      nixos-rebuild
      nmap
      openssh
      pass
      pinentry_mac
      pkg-config
      python311
      ripgrep
      rsync
      skhd
      terraformer
      tldr
      vault
      yabai
      yubikey-manager
  ];

  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Linux builder to support x86_64-linux
  nix.linux-builder = {
    enable = false;
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
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

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

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
        #cleanup = "uninstall"; # uninstall, zap
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)

    caskArgs.no_quarantine = true;
    casks = [
      "balenaetcher"
      "signal"
    ];
  };
}
