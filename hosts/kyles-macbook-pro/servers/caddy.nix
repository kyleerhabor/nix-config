{ config, ... }: let
  # I don't see a way to include secrets without requiring impure evaluation.
  #
  # I don't want to make this an option because we shouldn't be doing this in the first place.
  local = import /Users/kyleerhabor/.config/nix-config/local.nix;
in {
  launchd.daemons.caddy.serviceConfig.Label = config.my.servers.caddy.daemonID;
  launchd.daemons.caddy.serviceConfig.ProgramArguments = [
    "${config.my.servers.caddy.package}/bin/caddy" "run"
    "--config" "${config.my.servers.caddy.caddyfile}"
    "--adapter" "caddyfile"
  ];

  launchd.daemons.caddy.serviceConfig.RunAtLoad = true;
  launchd.daemons.caddy.serviceConfig.KeepAlive = true;
  launchd.daemons.caddy.serviceConfig.StandardOutPath = config.my.servers.caddy.daemonStandardFile;
  launchd.daemons.caddy.serviceConfig.StandardErrorPath = config.my.servers.caddy.daemonStandardFile;
  launchd.daemons.caddy.serviceConfig.EnvironmentVariables.PORKBUN_API_KEY = local.home.kyleerhabor.porkbun.apiKey;
  launchd.daemons.caddy.serviceConfig.EnvironmentVariables.PORKBUN_SECRET_KEY = local.home.kyleerhabor.porkbun.secretKey;
  launchd.daemons.caddy.serviceConfig.UserName = config.my.user.name;
}
