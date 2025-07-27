{
  ...
}:

{
  users.mutableUsers = false;

  users.users.yakimant = {
    isNormalUser = true;
    description = "yakimant";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJXqUxcqsY1U4xG1WlRS0WCaFHeF1MXp3wWhCPuW+b2rAAAADHNzaDpuby10b3VjaA== yakimant@gmail.com"
      "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDSUvodIwcGaDJU79/Ds38fLVwBb3EqpTPplYB0xH0qNAAAADHNzaDpuby10b3VjaA== yakimant@gmail.com"
    ];
    hashedPassword = "$y$j9T$3s/rC.yqNyNobdespcGNJ/$PYrHL9yWCdEy4WsjHHXGt9edvLD/YqpVXjZKKKxbKk/";
  };

  security.sudo.wheelNeedsPassword = false;
}
