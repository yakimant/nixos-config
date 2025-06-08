{ inputs, pkgs, ... }:

{
  programs.zsh.enableGlobalCompInit = false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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

  nix.distributedBuilds = true;

  # TODO: setup a machine for personal needs
  #nix.buildMachines = [
  #  {
  #    hostName = "some host";
  #    protocol = "ssh-ng";
  #    maxJobs = 16;
  #    system = "x86_64-linux";
  #    sshUser = "yakimant";
  #    #publicHostKey = "";
  #    #sshKey = "/Users/status/.ssh/id_ed25519_sk_no_touch";
  #  }
  #];

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
    builders-use-substitutes = true
  '';

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs-darwin}" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs-darwin;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs-darwin}";

  networking.knownNetworkServices = [
    "Wi-Fi"
  ];
}
