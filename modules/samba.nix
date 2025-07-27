{ config, ...}:

{
  services.samba = {
    enable = true;
    openFirewall = true;

    # https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html
    settings = {
      global = {
        "netbios name" = config.networking.hostName;

        # auth
        # NOTE: add users by `sudo smbpass -a USER`
        "security" = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";

        # filter hosts
        "hosts allow" = "100.64.0.0/255.192.0.0 192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0"; # ALL
        #"bind interfaces only" = true; # filter interfaces too

        # printers (disable)
        "load printers" = false;
        "printcap name" = "/dev/null";
        "printing" = "bsd";
      };
      #"public" = {
      #  "path" = "/data/public";
      #  "browseable" = "yes"; # default
      #  "writeable" = "yes"; # make no?
      #  "guest ok" = "yes";
      #  "guest only" = "yes";
      #  "create mask" = "0644"; # cut exec
      #};
      "files" = {
        "path" = "/data/files";
        "browseable" = "no";
        "writeable" = "yes";
        #"guest ok" = "no"; default
        "create mask" = "0644"; # cut exec
      };
    };
  };

  users.users.yana = {
    isNormalUser = true;
  };
}
