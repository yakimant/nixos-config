{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      # mac specific
      grandperspective
      pinentry_mac
      skhd
      pkgs.unstable.yabai
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
      "Amphetamine" = 937984704;
      #"Bitwarden" = 1352778147; # causing troubles to skhd
      "Endel" = 1346247457;
      #"Gapplin" = 768053424; #name changed?
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      #"PeakHour 4" = 1241445112;
      "PeakHour" = 1560576252;
      "Reeder" = 1529448980;
      "Remote Desktop" = 409907375;
      "WireGuard" = 1451685025;
    };

    caskArgs.no_quarantine = true;
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
        "avg-antivirus"
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
        "google-cloud-sdk"
        "google-drive"
        "gotomeeting"
        "handbrake"
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
        "parallels"
        "peakhour"
        "podman-desktop"
        "poe"
        "proton-mail-bridge"
        "protonvpn"
        "rar"
        "rocket-chat"
        "rstudio"
        "signal"
        "slack"
        "spotify"
        # "stats"
        "status"
        "tailscale"
        "tableau-public"
        "telegram"
        "the-clock"
        "tor-browser"
        "transmission"
        "tunnelbear"
        "ubiquiti-unifi-controller"
        "utm"
        # "viber"
        "vlc"
        "vmware-fusion"
        "windows-app"
        "xquartz"
        "yandex"
        "yandex-cloud-cli"
        "yandex-disk"
        "zoom"
      ];
  };
}
