{ inputs, pkgs, ... }:

# TODO:
#   meld
# microsoft-remote-desktop
#  peakhour4
#  gimp
#  macwhisper
#  proton mail bridge

#Uninstalling abseil... (772 files, 11.8MB)
#Uninstalling age... (10 files, 7.5MB)
#Uninstalling certifi... (38 files, 34.7KB)
#Uninstalling pycparser... (98 files, 1.8MB)
#Uninstalling cffi... (96 files, 1.7MB)
#Uninstalling cryptography... (320 files, 12.4MB)
#Uninstalling libsodium... (78 files, 888.9KB)
#Uninstalling libssh... (25 files, 1.4MB)
#Uninstalling libyaml... (10 files, 351.4KB)
#Uninstalling python@3.12... (3,252 files, 65.4MB)
#Uninstalling ansible... (32,696 files, 371.2MB)
#Uninstalling brotli... (24 files, 1012.7KB)
#Uninstalling giflib... (20 files, 547.1KB)
#Uninstalling highway... (75 files, 4.2MB)
#Uninstalling imath... (50 files, 947.3KB)
#Uninstalling jpeg-turbo... (45 files, 3.4MB)
#Uninstalling libpng... (28 files, 1.3MB)
#Uninstalling lz4... (24 files, 714.2KB)
#Uninstalling zstd... (31 files, 2.2MB)
#Uninstalling libtiff... (486 files, 8.5MB)
#Uninstalling little-cms2... (22 files, 1.4MB)
#Uninstalling libdeflate... (17 files, 324.6KB)
#Uninstalling openexr... (210 files, 6.1MB)
#Uninstalling webp... (63 files, 2.5MB)
#Uninstalling jpeg-xl... (64 files, 32.4MB)
#Uninstalling libvmaf... (234 files, 7.2MB)
#Uninstalling aom... (24 files, 10MB)
#Uninstalling gettext... (2,043 files, 24.4MB)
#Uninstalling libssh2... (197 files, 1.2MB)
#Uninstalling aria2... (65 files, 5.6MB)
#Uninstalling aribb24... (14 files, 203.8KB)
#Uninstalling libpcap... (111 files, 1MB)
#Uninstalling arp-scan... (19 files, 1.6MB)
#Uninstalling libnet... (82 files, 1.7MB)
#Uninstalling arping... (8 files, 150.4KB)
#Uninstalling aspell... (768 files, 322.9MB)
#Uninstalling dbus... (78 files, 2.6MB)
#Uninstalling pcre2... (237 files, 6.3MB)
#Uninstalling python-packaging... (74 files, 545.5KB)
#Uninstalling glib... (506 files, 36.3MB)
#Uninstalling xorgproto... (267 files, 3.9MB)
#Uninstalling libxau... (21 files, 123.6KB)
#Uninstalling libxdmcp... (11 files, 136.5KB)
#Uninstalling libxcb... (2,498 files, 7.5MB)
#Uninstalling libx11... (1,043 files, 7MB)
#Uninstalling libxext... (87 files, 450.9KB)
#Uninstalling libxfixes... (13 files, 147.2KB)
#Uninstalling libxi... (86 files, 701.4KB)
#Uninstalling libxtst... (23 files, 195.1KB)
#Uninstalling at-spi2-core... (200 files, 4.3MB)
#Uninstalling awscli... (13,980 files, 123.3MB)
#Uninstalling bash... (163 files, 12.4MB)
#Uninstalling bcrypt... (7 files, 47.8KB)
#Uninstalling berkeley-db@5... (5,272 files, 86.4MB)
#Uninstalling c-ares... (176 files, 1MB)
#Uninstalling libnghttp2... (14 files, 805.3KB)
#Uninstalling libuv... (20 files, 1.2MB)
#Uninstalling icu4c@75... (277 files, 78.8MB)
#Uninstalling node... (2,066 files, 78.6MB)
#Uninstalling bitwarden-cli... (7,974 files, 46.5MB)
#Uninstalling btop... (43 files, 1.2MB)
#Uninstalling freetype... (68 files, 2.5MB)
#Uninstalling fontconfig... (90 files, 2.4MB)
#Uninstalling libxrender... (12 files, 214KB)
#Uninstalling lzo... (31 files, 565.6KB)
#Uninstalling pixman... (11 files, 842.6KB)
#Uninstalling cairo... (53 files, 2.2MB)
#Uninstalling capstone... (31 files, 22.4MB)
#Uninstalling cjson... (24 files, 257.4KB)
#Uninstalling cmake... (3,424 files, 55.3MB)
#Uninstalling dtc... (19 files, 626.5KB)
#Uninstalling gmp... (21 files, 3.3MB)
#Uninstalling libevent... (57 files, 2.2MB)
#Uninstalling libunistring... (59 files, 5MB)
#Uninstalling libidn2... (80 files, 1MB)
#Uninstalling libtasn1... (61 files, 717.9KB)
#Uninstalling nettle... (96 files, 2.7MB)
#Uninstalling p11-kit... (31 files, 4.2MB)
#Uninstalling unbound... (59 files, 6.0MB)
#Uninstalling gnutls... (1,292 files, 10.8MB)
#Uninstalling libslirp... (12 files, 410.2KB)
#Uninstalling libusb... (22 files, 618KB)
#Uninstalling ncurses... (4,052 files, 9.9MB)
#Uninstalling snappy... (19 files, 172.3KB)
#Uninstalling vde... (66 files, 1.3MB)
#Uninstalling qemu... (165 files, 644.9MB)
#Uninstalling lima... (109 files, 202.5MB)
#Uninstalling colima... (11 files, 5.7MB)
#Uninstalling coreutils... (476 files, 13.5MB)
#Uninstalling csvq... (6 files, 15MB)
#Uninstalling rtmpdump... (20 files, 647.9KB)
#Uninstalling curl... (530 files, 4MB)
#Uninstalling dash... (6 files, 242KB)
#Uninstalling dav1d... (16 files, 944.9KB)
#Uninstalling diffr... (9 files, 714KB)
#Uninstalling direnv... (12 files, 10.5MB)
#Uninstalling docker-completion... (10 files, 342.3KB)
#Uninstalling docker... (14 files, 25.6MB)
#Uninstalling docker-buildx... (29 files, 54.8MB)
#Uninstalling docker-compose... (8 files, 52.7MB)
#Uninstalling doctl... (10 files, 32.5MB)
#Uninstalling python@3.13... (3,255 files, 65MB)
#Uninstalling docutils... (241 files, 2.1MB)
#Uninstalling evernote2md... (5 files, 4.2MB)
#Uninstalling libgit2... (106 files, 4.7MB)
#Uninstalling eza... (15 files, 1.3MB)
#Uninstalling fd... (14 files, 2.7MB)
#Uninstalling libogg... (103 files, 536.8KB)
#Uninstalling flac... (284 files, 6.9MB)
#Uninstalling frei0r... (157 files, 5.6MB)
#Uninstalling fribidi... (68 files, 568KB)
#Uninstalling graphite2... (18 files, 281.3KB)
#Uninstalling harfbuzz... (77 files, 9.7MB)
#Uninstalling lame... (27 files, 2.2MB)
#Uninstalling openjpeg... (538 files, 14.0MB)
#Uninstalling leptonica... (56 files, 7.0MB)
#Uninstalling libb2... (8 files, 109.6KB)
#Uninstalling libarchive... (65 files, 3.8MB)
#Uninstalling libunibreak... (18 files, 334.3KB)
#Uninstalling libass... (12 files, 1014.7KB)
#Uninstalling libbluray... (21 files, 1MB)
#Uninstalling libmicrohttpd... (25 files, 1.5MB)
#Uninstalling mbedtls... (200 files, 13.2MB)
#Uninstalling librist... (28 files, 795.2KB)
#Uninstalling libsamplerate... (32 files, 3MB)
#Uninstalling libvorbis... (157 files, 2.4MB)
#Uninstalling mpg123... (34 files, 2.0MB)
#Uninstalling opus... (15 files, 1MB)
#Uninstalling libsndfile... (53 files, 1MB)
#Uninstalling libsoxr... (29 files, 323.5KB)
#Uninstalling libvidstab... (25 files, 188.0KB)
#Uninstalling libvpx... (20 files, 3.7MB)
#Uninstalling opencore-amr... (17 files, 655.1KB)
#Uninstalling pango... (69 files, 3.4MB)
#Uninstalling rav1e... (14 files, 45.5MB)
#Uninstalling rubberband... (13 files, 1.7MB)
#Uninstalling sdl2... (94 files, 6.5MB)
#Uninstalling speex... (25 files, 855.6KB)
#Uninstalling srt... (20 files, 4.4MB)
#Uninstalling svt-av1... (19 files, 2.9MB)
#Uninstalling tesseract... (75 files, 33MB)
#Uninstalling theora... (97 files, 2MB)
#Uninstalling x264... (11 files, 4.2MB)
#Uninstalling x265... (11 files, 12MB)
#Uninstalling xvid... (10 files, 1.2MB)
#Uninstalling zeromq... (84 files, 6.2MB)
#Uninstalling zimg... (27 files, 1.1MB)
#Uninstalling ffmpeg... (287 files, 52.3MB)
#Uninstalling fswatch... (52 files, 1.3MB)
#Uninstalling fzf... (18 files, 4.3MB)
#Uninstalling isl... (74 files, 7.6MB)
#Uninstalling mpfr... (30 files, 3.1MB)
#Uninstalling libmpc... (12 files, 470.2KB)
#Uninstalling gcc... (1,913 files, 473.4MB)
#Uninstalling gdbm... (26 files, 1MB)
#Uninstalling gdk-pixbuf... (152 files, 4.0MB)
#Uninstalling gh... (201 files, 41.2MB)
#Uninstalling jbig2dec... (13 files, 422.9KB)
#Uninstalling libidn... (73 files, 1MB)
#Uninstalling ghostscript... (640 files, 122MB)
#Uninstalling gnu-getopt... (13 files, 224.0KB)
#Uninstalling libgpg-error... (50 files, 1.7MB)
#Uninstalling libassuan... (18 files, 562.6KB)
#Uninstalling libgcrypt... (23 files, 3.3MB)
#Uninstalling libksba... (19 files, 528.6KB)
#Uninstalling npth... (12 files, 162.2KB)
#Uninstalling pinentry... (13 files, 456.4KB)
#Uninstalling gnupg... (141 files, 14.4MB)
#Uninstalling go... (13,234 files, 268.2MB)
#Uninstalling gpgme... (108 files, 4.7MB)
#Uninstalling hicolor-icon-theme... (8 files, 80.9KB)
#Uninstalling gtk+... (1,196 files, 59.8MB)
#Uninstalling helix... (1,001 files, 181.3MB)
#Uninstalling hopenpgp-tools... (8 files, 348.2MB)
#Uninstalling htop... (12 files, 372.7KB)
#Uninstalling hugo... (53 files, 68.9MB)
#Uninstalling hyperfine... (13 files, 1.1MB)
#Uninstalling jasper... (45 files, 1.6MB)
#Uninstalling libde265... (21 files, 1.5MB)
#Uninstalling shared-mime-info... (88 files, 4.7MB)
#Uninstalling libheif... (32 files, 4.1MB)
#Uninstalling liblqr... (114 files, 332.6KB)
#Uninstalling libomp... (9 files, 1.7MB)
#Uninstalling libraw... (74 files, 6.0MB)
#Uninstalling m4... (13 files, 742.6KB)
#Uninstalling libtool... (76 files, 3.9MB)
#Uninstalling imagemagick... (808 files, 32.3MB)
#Uninstalling jansson... (12 files, 231.0KB)
#Uninstalling oniguruma... (14 files, 1.4MB)
#Uninstalling jq... (19 files, 1.4MB)
#Uninstalling json-c... (34 files, 358.7KB)
#Uninstalling just... (13 files, 3.8MB)
#Uninstalling keyring... (156 files, 689.9KB)
#Uninstalling krb5... (163 files, 5.6MB)
#Uninstalling lazygit... (6 files, 26.2MB)
#Uninstalling ldns... (573 files, 7.2MB)
#Uninstalling libassuan@2... (18 files, 533.3KB)
#Uninstalling libcbor... (34 files, 201.9KB)
#Uninstalling libfido2... (562 files, 1.3MB)
#Uninstalling libgnt... (96 files, 1.5MB)
#Uninstalling libice... (17 files, 356KB)
#Uninstalling liblinear... (9 files, 323.4KB)
#Uninstalling libmagic... (357 files, 10.2MB)
#Uninstalling libolm... (20 files, 277.3KB)
#Uninstalling libotr... (43 files, 776.6KB)
#Uninstalling libscrypt... (7 files, 79.2KB)
#Uninstalling libsm... (13 files, 200.8KB)
#Uninstalling libvterm... (12 files, 391.0KB)
#Uninstalling libxt... (311 files, 1.7MB)
#Uninstalling libyubikey... (17 files, 251.8KB)
#Uninstalling libzip... (155 files, 915.5KB)
#Uninstalling lpeg... (14 files, 316.8KB)
#Uninstalling lua... (30 files, 790.6KB)
#Uninstalling luajit... (56 files, 2.1MB)
#Uninstalling luv... (15 files, 853.7KB)
#Uninstalling openjdk... (602 files, 337.6MB)
#Uninstalling maven... (94 files, 10.2MB)
#Uninstalling md4c... (20 files, 302.1KB)
#Uninstalling mdbook... (12 files, 12.6MB)
#Uninstalling miniupnpc... (24 files, 339KB)
#Uninstalling protobuf... (434 files, 15.0MB)
#Uninstalling mosh... (16 files, 906.7KB)
#Uninstalling msgpack... (39 files, 226.3KB)
#Uninstalling mtr... (13 files, 264.9KB)
#Uninstalling ncdu... (7 files, 487.5KB)
#Uninstalling tree-sitter... (15 files, 15.2MB)
#Uninstalling unibilium... (64 files, 327.9KB)
#Uninstalling neovim... (1,902 files, 29.8MB)
#Uninstalling nmap... (835 files, 28.0MB)
#Uninstalling openblas... (24 files, 48.3MB)
#Uninstalling openfortivpn... (13 files, 216.6KB)
#Uninstalling openjdk@21... (600 files, 330.5MB)
#Uninstalling openldap... (342 files, 7.8MB)
#Uninstalling openssh... (47 files, 6.8MB)
#Uninstalling qrencode... (13 files, 309.0KB)
#Uninstalling tree... (9 files, 182.1KB)
#Uninstalling pass... (34 files, 155.9KB)
#Uninstalling pcre... (204 files, 4.6MB)
#Uninstalling perl... (2,517 files, 67.8MB)
#Uninstalling pidgin... (899 files, 31.2MB)
#Uninstalling pinentry-mac... (20 files, 524.9KB)
#Uninstalling podman... (201 files, 76.2MB)
#Uninstalling postgresql@15... (3,706 files, 62.8MB)
#Uninstalling postgresql@16... (3,802 files, 68.5MB)
#Uninstalling python@3.10... (3,081 files, 56.7MB)
#Uninstalling qsv... (13 files, 19.9MB)
#Uninstalling qt@5... (10,849 files, 341.8MB)
#Uninstalling tcl-tk... (3,070 files, 53.3MB)
#Uninstalling r... (2,488 files, 71.8MB)
#Uninstalling ripgrep... (14 files, 6MB)
#Uninstalling ruby... (19,852 files, 51.8MB)
#Uninstalling s3cmd... (98 files, 1.1MB)
#Uninstalling sheldon... (11 files, 4.2MB)
#Uninstalling shellcheck... (7 files, 66.7MB)
#Uninstalling signal-cli... (39 files, 42.5MB)
#Uninstalling skopeo... (23 files, 37.3MB)
#Uninstalling socat... (16 files, 961.7KB)
#Uninstalling speedtest-cli... (8 files, 97.2KB)
#Uninstalling sqlite-analyzer... (6 files, 879.4KB)
#Uninstalling starship... (12 files, 6.6MB)
#Uninstalling stow... (50 files, 937.5KB)
#Uninstalling telnet... (5 files, 207.6KB)
#Uninstalling the_silver_searcher... (10 files, 148.1KB)
#Uninstalling tldr... (10 files, 105.1KB)
#Uninstalling utf8proc... (10 files, 768.6KB)
#Uninstalling tmux... (10 files, 1.2MB)
#Uninstalling tor... (26 files, 22MB)
#Uninstalling transmission-cli... (67 files, 11MB)
#Uninstalling weechat... (69 files, 9.7MB)
#Uninstalling wget... (91 files, 4.5MB)
#Uninstalling xcodes... (6 files, 6.3MB)
#Uninstalling xq... (7 files, 6.8MB)
#Uninstalling ykman... (350 files, 2.7MB)
#Uninstalling ykpers... (23 files, 671.3KB)
#Uninstalling youtube-dl... (847 files, 5.9MB)
#Uninstalling yq... (10 files, 9.7MB)
#Uninstalling yt-dlp... (1,696 files, 18.7MB)
#Uninstalling zbar... (33 files, 876.5KB)
#Uninstalling consul... (7 files, 169.7MB)
#Uninstalling terraform... (5 files, 83.9MB)
#Uninstalling skhd... (7 files, 128.6KB)
#Uninstalling yabai... (7 files, 1.7MB)
#Uninstalling m1-terraform-provider-helper... (7 files, 12.8MB)
#Uninstalling s5cmd... (7 files, 15.8MB)
#Uninstalling snyk... (4 files, 98.5MB)
#Uninstalling fq... (4 files, 11.9MB)

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
      # mac specific
      pinentry_mac
      skhd
      yabai
      yubikey-manager
      grandperspective

      # desktop specific
      nerdfonts
      age
      age-plugin-yubikey
    #ansible_2_16
    #ansible-lint
      just
      passage
      bitwarden-cli
      cachix
      cf-terraforming
      colima
      direnv
      docker
      fswatch
      gnupg
      go
      makefile2graph
      nixos-anywhere
      nixos-rebuild
      pass
      pkg-config
      terraformer
    #vault
      yt-dlp
  ];

  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.

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

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
#nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["status" "@admin"];
    substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

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
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    #
      #brewfile = true;

    masApps = {
      "Amphetamine" = 937984704;
      "Bitwarden" = 1352778147;
      "Endel" = 1346247457;
      #"Gapplin" = 768053424; #name changed?
      #"GarageBand" = 682658836;
      #"iMovie" = 408981434;
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "PeakHour" = 1560576252;
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
      #{ greedy = true; name = "bartender"; }
      { greedy = true; name = "bluestacks"; }
      { greedy = true; name = "brave-browser"; }
      { greedy = true; name = "bruno"; }
      { greedy = true; name = "chatgpt"; }
      { greedy = true; name = "chromium"; }
      { greedy = true; name = "cold-turkey-blocker"; }
      { greedy = true; name = "cyberduck"; }
      { greedy = true; name = "dash"; }
      { greedy = true; name = "db-browser-for-sqlite"; }
      { greedy = true; name = "dbeaver-community"; }
      { greedy = true; name = "discord"; }
      { greedy = true; name = "dropbox"; }
      { greedy = true; name = "element"; }
      { greedy = true; name = "firefox"; }
      #{ greedy = true; name = "font-fira-code-nerd-font"; }
      { greedy = true; name = "github"; }
      { greedy = true; name = "gnucash"; }
      { greedy = true; name = "google-chrome"; }
      { greedy = true; name = "google-cloud-sdk"; }
      { greedy = true; name = "google-drive"; }
      { greedy = true; name = "gotomeeting"; }
      #{ greedy = true; name = "grandperspective"; }
      { greedy = true; name = "kaleidoscope"; }
      { greedy = true; name = "karabiner-elements"; }
      { greedy = true; name = "karafun"; }
      { greedy = true; name = "ledger-live"; }
      { greedy = true; name = "libreoffice"; }
      { greedy = true; name = "logitech-camera-settings"; }
      { greedy = true; name = "macfuse"; }
      { greedy = true; name = "microsoft-auto-update"; }
      { greedy = true; name = "microsoft-edge"; }
      { greedy = true; name = "microsoft-office"; }
      { greedy = true; name = "microsoft-remote-desktop"; }
      { greedy = true; name = "microsoft-teams"; }
      { greedy = true; name = "netspot"; }
      { greedy = true; name = "nextcloud"; }
      { greedy = true; name = "onlyoffice"; }
      { greedy = true; name = "parallels"; }
      { greedy = true; name = "podman-desktop"; }
      { greedy = true; name = "poe"; }
      { greedy = true; name = "protonmail-bridge"; }
      { greedy = true; name = "protonvpn"; }
      { greedy = true; name = "rar"; }
      { greedy = true; name = "rocket-chat"; }
      { greedy = true; name = "rstudio"; }
      { greedy = true; name = "signal"; }
      { greedy = true; name = "skype"; }
      { greedy = true; name = "slack"; }
      { greedy = true; name = "spaceman"; }
      { greedy = true; name = "spotify"; }
      #{ greedy = true; name = "sublime-text"; }
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
      { greedy = true; name = "xquartz"; }
      { greedy = true; name = "yandex"; }
      { greedy = true; name = "yandex-cloud-cli"; }
      { greedy = true; name = "yandex-disk"; }
      { greedy = true; name = "zoom"; }
    ];
  };
}
