{ config, ... }: {
  launchd.daemons.navidrome.serviceConfig.Label = config.my.servers.navidrome.daemonID;
  launchd.daemons.navidrome.serviceConfig.ProgramArguments = [
    "${config.my.servers.navidrome.package}/bin/navidrome"
    "--configfile" "${config.my.servers.navidrome.configurationFile}"
  ];

  launchd.daemons.navidrome.serviceConfig.RunAtLoad = true;
  launchd.daemons.navidrome.serviceConfig.KeepAlive = true;
  launchd.daemons.navidrome.serviceConfig.StandardOutPath = config.my.servers.navidrome.daemonStandardFile;
  launchd.daemons.navidrome.serviceConfig.StandardErrorPath = config.my.servers.navidrome.daemonStandardFile;
  launchd.daemons.navidrome.serviceConfig.UserName = config.my.user.name;
}
