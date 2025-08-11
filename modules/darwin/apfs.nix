{
  # macOS is purging older that 24h (probably Time Machine)
  launchd.daemons.apfs-snapshot = {
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/tmutil"
        "snapshot"
      ];
      StartCalendarInterval = [{
        Minute = 0;
      }];
    };
  };
}
