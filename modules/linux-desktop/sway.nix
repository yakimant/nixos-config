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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      };
    };
  };
}
