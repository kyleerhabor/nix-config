{ config, ... }: {
  launchd.user.agents.komga.serviceConfig.Label = config.my.servers.komga.daemonID;
  launchd.user.agents.komga.serviceConfig.ProgramArguments = [
    "${config.my.servers.komga.package}/bin/komga"
    "--spring.config.additional-location=${config.my.servers.komga.configurationFile}"
  ];

  launchd.user.agents.komga.serviceConfig.RunAtLoad = true;
  launchd.user.agents.komga.serviceConfig.KeepAlive = true;
}
