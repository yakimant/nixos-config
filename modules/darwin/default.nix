{ inputs, pkgs, ... }:

{
  imports = [
    ./packages.nix
    inputs.yknotify-rs.darwinModules.default
  ];

  services.yknotify-rs.enable = true;

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

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = false;
        Bluetooth = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
        Sound = false;
      };

      universalaccess = {
        reduceMotion = true;
        reduceTransparency = true;
      };

      #".GlobalPreferences"."com.apple.mouse.scaling" = 1.0
      #CustomSystemPreferences
      #LaunchServices.LSQuarantine = false;
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      #controlcenter
      finder.CreateDesktop = true;
      dock = {
        autohide = true;
        mru-spaces = false;
      };
      #dock
      #screencapture.location
      trackpad = {
        #more
        ActuationStrength = 0;
        Clicking = true;
        FirstClickThreshold = 0;
      };
      WindowManager = {
        EnableStandardClickToShowDesktop = false; # for yabai
      };
      NSGlobalDomain = {
        #NSGlobalDomain.InitialKeyRepeat
        #NSGlobalDomain.KeyRepeat
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleICUForce24HourTime = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        #NSAutomaticWindowAnimationsEnabled
        "com.apple.trackpad.forceClick" = false;
        "com.apple.trackpad.scaling" = 3.0;
      };
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
