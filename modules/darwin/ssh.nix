{ pkgs,... }:

{
  launchd.user.agents.ssh-agent = {
    path = [ pkgs.openssh ];
    command = "ssh-agent -D -a $TMPDIR/ssh-agent.sock";
    serviceConfig = {
      Label = "local.user.ssh-agent";
      KeepAlive = true;
      RunAtLoad = true;
      # WARN: Shared across users
      StandardErrorPath = "/tmp/ssh-agent.err";
      StandardOutPath = "/tmp/ssh-agent.out";
    };
  };
}
