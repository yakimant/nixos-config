{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    grim slurp # screenshots
    wl-clipboard # clipboard
    mako # notifications
    brightnessctl # brightness
  ];

  programs.sway.enable = true;
  services.pipewire.enable = true;

  programs.waybar.enable = true;

  # TODO: fix for waybar
  # security.rtkit.enable = true;
  # services.dbus.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
  # };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      };
    };
  };
}
