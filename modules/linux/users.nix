{ config, ... }:

{
  age.secrets = {
    "users/yakimant/pass-hash" = {
      file = ../../secrets/users/yakimant/pass-hash.age;
    };
  };

  users.mutableUsers = false;

  users.users.yakimant = {
    isNormalUser = true;
    description = "yakimant";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJXqUxcqsY1U4xG1WlRS0WCaFHeF1MXp3wWhCPuW+b2rAAAADHNzaDpuby10b3VjaA=="
      "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDSUvodIwcGaDJU79/Ds38fLVwBb3EqpTPplYB0xH0qNAAAADHNzaDpuby10b3VjaA=="
    ];
    hashedPasswordFile = config.age.secrets."users/yakimant/pass-hash".path;
  };

  security.sudo.wheelNeedsPassword = false;
}
