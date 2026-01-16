{ inputs, ... }:

{
  imports = [
    ./apfs.nix
    ./builders.nix
    ./networking.nix
    ./packages.nix
    ./ssh.nix
    inputs.yknotify-rs.darwinModules.default
  ];

  services.yknotify-rs.enable = true;

  programs.zsh.enableGlobalCompInit = false;

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


  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs-darwin}" ];
    registry.nixpkgs.flake = inputs.nixpkgs-darwin;
  };

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs-darwin}";
}
