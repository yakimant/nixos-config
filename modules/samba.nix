{ config, ...}:

{
  services.samba = {
    enable = true;
    #securityType = "user";
    openFirewall = true;
    # https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html
    settings = {
      global = {
        "netbios name" = config.networking.hostName;

        #"server string" = "smbnix";
        #"workgroup" = "WORKGROUP";
        #"use sendfile" = "yes"; speedup
        #"max protocol" = "smb2";
        #"name resolve order" = "bcast host";
        #"bind interfaces only" = true;

        # auth
        "security" = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";

        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0"; # ALL

        # printers
        "load printers" = false;
        "printcap name" = "/dev/null";
        "printing" = "bsd";
      };
      "public" = {
        "path" = "/data/public";
        "browseable" = "yes"; # default
        "writeable" = "yes"; # make no?
        "guest ok" = "yes";
        "guest only" = "yes";
        "create mask" = "0644"; # cut x
        # "directory mask" = "0755"; default
        #"force user" = "username";
        #"force group" = "groupname";
      };
      "private" = {
        "path" = "/data/private";
        "browseable" = "yes"; # make no?
        "writeable" = "yes"; # default
        #"guest ok" = "no"; default
        "create mask" = "0644"; # cut x
        # "directory mask" = "0755"; default
        #"force user" = "username";
        #"force group" = "groupname";
      };
    };
  };

  #services.samba-wsdd = {
  #  enable = true;
  #  openFirewall = true;
  #};
}
