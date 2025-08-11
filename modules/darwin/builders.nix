{ pkgs, ... }:

{
  # Install Rosetta 2 to support x86_64-darwin
  # $ softwareupdate --install-rosetta --agree-to-license
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
    builders-use-substitutes = true
  '';

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

  nix.distributedBuilds = true;

  # TODO: setup a machine for personal needs
  #nix.buildMachines = [
  #  {
  #    hostName = "some host";
  #    protocol = "ssh-ng";
  #    maxJobs = 16;
  #    system = "x86_64-linux";
  #    sshUser = "yakimant";
  #    #publicHostKey = "";
  #    #sshKey = "/Users/status/.ssh/id_ed25519_sk_no_touch";
  #  }
  #];
}
