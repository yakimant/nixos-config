{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      inputs.agenix.packages.aarch64-darwin.default
      grandperspective
      skhd
      unstable.yabai
      yubikey-manager
      xcodes
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # updates homebrew packages on activation,
      # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
      upgrade = true;
      cleanup = "zap";
    };

    global.brewfile = true;

    brews = [
      "ncdu"
      "m1-terraform-provider-helper"
      "go" # required for m1-terraform-provider-helper
    ];

    taps = [
      "kreuzwerker/taps" # for m1-terraform-provider-helper
      #"homebrew/cask"
    ];

    # $ mas list
    # remove manually
    masApps = {
      "Amphetamine"    = 937984704;
      #"Bitwarden"      = 1352778147; # causing troubles to skhd
      "Endel"          = 1346247457;
      #"Gapplin"        = 768053424; #name changed?
      "Keynote"        = 409183694;
      "Numbers"        = 409203825;
      "Pages"          = 409201541;
      #"PeakHour 4"     = 1241445112;
      "PeakHour"       = 1560576252;
      "Reeder"         = 1529448980;
      "Remote Desktop" = 409907375;
      "WireGuard"      = 1451685025;
    };

    caskArgs.no_quarantine = true;
    # TODO: upgrade to 25.11
    #greedyCasks = true;
    casks = let
      greedyCasks = names: map (name: { greedy = true; inherit name; }) names;
    in
      greedyCasks [
        "1password"
        "adium"
        "aegisub"
        "alacritty"
        "android-commandlinetools"
        "balenaetcher"
        "bluestacks"
        "brave-browser"
        "bruno"
        "chatgpt"
        "chromium"
        "cold-turkey-blocker"
        "cyberduck"
        "db-browser-for-sqlite"
        "dbeaver-community"
        "discord"
        "dropbox"
        "element"
        "firefox"
        "github"
        "google-chrome"
        "google-drive"
        "gotomeeting"
        "handbrake-app"
        "jordanbaird-ice"
        "kaleidoscope"
        "karabiner-elements"
        "karafun"
        "libreoffice"
        "logitech-camera-settings"
        "maccy"
        "macfuse"
        "macwhisper"
        "microsoft-edge"
        "microsoft-office"
        "microsoft-teams"
        "netspot"
        "nextcloud"
        "onlyoffice"
        "openzfs"
        "parallels"
        "peakhour"
        "proton-mail-bridge"
        "protonvpn"
        "qgis"
        "rar"
        "rocket-chat"
        "signal"
        "slack"
        "spotify"
        "status"
        "tailscale-app"
        "tableau-public"
        "telegram"
        "the-clock"
        "tor-browser"
        "transmission"
        "tunnelbear"
        "ubiquiti-unifi-controller"
        "utm"
        # https://github.com/orgs/Homebrew/discussions/6181
        # "viber"
        "vlc"
        "vmware-fusion"
        "windows-app"
        "xquartz"
        "yandex"
        "yandex-disk"
        "zoom"
      ];
  };
}
