{
  services.keyd = {
    enable = true;
    keyboards = {
      thinkpad = {
        ids = ["0001:0001:70533846"];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            leftalt = "layer(control)";
            control = "layer(nav)";
            left = "noop";
            right = "noop";
            up = "noop";
            down = "noop";
          };
          control = {
            # TODO: disable later
            #"[" = "noop";
            #"v" = "noop";
          };
          nav = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };

      pok3r = {
        ids = ["0f39:0618:67105f83"];
        settings = {
          main = {
            #capslock = "overload(control, esc)";
            meta = "layer(control)";
            leftalt = "layer(meta)";
          };
          control = {
            # TODO: disable later
            #"[" = "noop";
            #"v" = "noop";
          };
        };
      };
    };
  };
}
