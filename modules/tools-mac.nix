{ inputs, pkgs, ... }:

# TODO: brew or appstore

{
  environment.systemPackages = with pkgs; [
      # mac specific
      grandperspective
      pinentry_mac
      skhd
      yabai
      yubikey-manager
      xcodes
  ];


  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    #
      #brewfile = true;

    brews = [
      "ncdu"
      "m1-terraform-provider-helper"
      "go" # required for m1-terraform-provider-helper
    ];

    taps = [
      "kreuzwerker/taps" # for m1-terraform-provider-helper
    ];

    masApps = {
      "Amphetamine" = 937984704;
      #"Bitwarden" = 1352778147; # causing troubles to skhd
      "Endel" = 1346247457;
      #"Gapplin" = 768053424; #name changed?
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      #"PeakHour" = 1560576252;
      "Reeder" = 1529448980;
      "Remote Desktop" = 409907375;
      "WireGuard" = 1451685025;
    };

    caskArgs.no_quarantine = true;
    casks = [
      { greedy = true; name = "1password"; }
      { greedy = true; name = "adium"; }
      { greedy = true; name = "alacritty"; }
      { greedy = true; name = "android-commandlinetools"; }
      { greedy = true; name = "balenaetcher"; }
      { greedy = true; name = "bluestacks"; }
      { greedy = true; name = "brave-browser"; }
      { greedy = true; name = "bruno"; }
      { greedy = true; name = "chatgpt"; }
      { greedy = true; name = "chromium"; }
      { greedy = true; name = "cold-turkey-blocker"; }
      { greedy = true; name = "cyberduck"; }
      { greedy = true; name = "db-browser-for-sqlite"; }
      { greedy = true; name = "dbeaver-community"; }
      { greedy = true; name = "discord"; }
      { greedy = true; name = "dropbox"; }
      { greedy = true; name = "element"; }
      { greedy = true; name = "firefox"; }
      { greedy = true; name = "github"; }
      { greedy = true; name = "google-chrome"; }
      { greedy = true; name = "google-cloud-sdk"; }
      { greedy = true; name = "google-drive"; }
      { greedy = true; name = "gotomeeting"; }
      { greedy = true; name = "jordanbaird-ice"; }
      { greedy = true; name = "kaleidoscope"; }
      { greedy = true; name = "karabiner-elements"; }
      { greedy = true; name = "karafun"; }
      { greedy = true; name = "ledger-live"; }
      { greedy = true; name = "libreoffice"; }
      { greedy = true; name = "logitech-camera-settings"; }
      { greedy = true; name = "macfuse"; }
      { greedy = true; name = "macwhisper"; }
#      { greedy = true; name = "microsoft-auto-update"; }
      { greedy = true; name = "microsoft-edge"; }
      { greedy = true; name = "microsoft-office"; }
      { greedy = true; name = "microsoft-teams"; }
      { greedy = true; name = "netspot"; }
      { greedy = true; name = "nextcloud"; }
      { greedy = true; name = "onlyoffice"; }
      { greedy = true; name = "parallels"; }
      { greedy = true; name = "peakhour"; }
      { greedy = true; name = "podman-desktop"; }
      { greedy = true; name = "poe"; }
      { greedy = true; name = "proton-mail-bridge"; }
      { greedy = true; name = "protonvpn"; }
      { greedy = true; name = "rar"; }
      { greedy = true; name = "rocket-chat"; }
      { greedy = true; name = "rstudio"; }
      { greedy = true; name = "signal"; }
      { greedy = true; name = "skype"; }
      { greedy = true; name = "slack"; }
      { greedy = true; name = "spaceman"; }
      { greedy = true; name = "spotify"; }
      { greedy = true; name = "tailscale"; }
      { greedy = true; name = "tableau-public"; }
      { greedy = true; name = "telegram"; }
      { greedy = true; name = "the-clock"; }
      { greedy = true; name = "tor-browser"; }
      { greedy = true; name = "transmission"; }
      { greedy = true; name = "tunnelbear"; }
      { greedy = true; name = "ubiquiti-unifi-controller"; }
      { greedy = true; name = "utm"; }
      { greedy = true; name = "viber"; }
      { greedy = true; name = "vlc"; }
      { greedy = true; name = "vmware-fusion"; }
      { greedy = true; name = "windows-app"; }
      { greedy = true; name = "xquartz"; }
      { greedy = true; name = "yandex"; }
      { greedy = true; name = "yandex-cloud-cli"; }
      { greedy = true; name = "yandex-disk"; }
      { greedy = true; name = "zoom"; }
    ];
  };
}
