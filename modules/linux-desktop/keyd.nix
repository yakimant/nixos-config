{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
        leftalt = "layer(control)";
        control = "layer(nav)";
        left = "noop";
        right = "noop";
        up = "noop";
        down = "noop";
        "control+[" = "noop";
      };
      control = {
        "[" = "noop";
      };
      nav = {
        h = "left";
        j = "down";
        k = "up";
        l = "right";
      };
    };
  };
}
