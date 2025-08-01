{
  launchd.daemons.apfs-snapshot = {
    # TODO: keep 14 (2 weeks)
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/tmutil"
        "snapshot"
      ];
      RunAtLoad = true;
      StartInterval = 86400;
    };
  };
}
