{ config, ... }: {
  launchd.daemons.komga.serviceConfig.Label = config.my.servers.komga.daemonID;
  launchd.daemons.komga.serviceConfig.ProgramArguments = [
    "${config.my.servers.komga.package}/bin/komga"
    "--spring.config.additional-location=${config.my.servers.komga.configurationFile}"
  ];

  launchd.daemons.komga.serviceConfig.RunAtLoad = true;
  launchd.daemons.komga.serviceConfig.KeepAlive = true;
  launchd.daemons.komga.serviceConfig.UserName = config.my.user.name;
}
