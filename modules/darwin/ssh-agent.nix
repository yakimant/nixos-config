{ pkgs,... }:

{
  launchd.user.agents.ssh-agent = {
    path = [ pkgs.openssh ];
    # script, command, serviceConfig.Program, serviceConfig.ProgramArguments
    command = "ssh-agent -D -a $SSH_AUTH_SOCK";
    #environment = {
    #  BURK
    #  SSH_ASKPASS, SSH_ASKPASS_REQUIRE force, DISPLAY :0
    #}
    serviceConfig = {
      Label = "local.ssh-agent"
      KeepAlive = true;
      RunAtLoad = true;
      #Sockets
      StandardErrorPath = "$XDG_STATE_HOME/ssh-agent.err";
      StandardOutPath = "$XDG_STATE_HOME/ssh-agent.out";
      #EnvironmentVariables
    };
  };
}
