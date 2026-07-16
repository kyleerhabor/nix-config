{ config, ... }: {
  launchd.user.agents.navidrome.serviceConfig.Label = config.my.servers.navidrome.daemonID;
  launchd.user.agents.navidrome.serviceConfig.ProgramArguments = [
    "${config.my.servers.navidrome.package}/bin/navidrome"
    "--configfile" "${config.my.servers.navidrome.configurationFile}"
  ];

  launchd.user.agents.navidrome.serviceConfig.RunAtLoad = true;
  launchd.user.agents.navidrome.serviceConfig.KeepAlive = true;
  launchd.user.agents.navidrome.serviceConfig.StandardOutPath = config.my.servers.navidrome.daemonStandardFile;
  launchd.user.agents.navidrome.serviceConfig.StandardErrorPath = config.my.servers.navidrome.daemonStandardFile;
}
