{ config, ... }: let
  # I don't see a way to include secrets without requiring impure evaluation.
  #
  # I don't want to make this an option because we shouldn't be doing this in the first place.
  local = import /Users/kyleerhabor/.config/nix-config/local.nix;
in {
  launchd.user.agents.caddy.serviceConfig.Label = config.my.servers.caddy.daemonID;
  launchd.user.agents.caddy.serviceConfig.ProgramArguments = [
    "${config.my.servers.caddy.package}/bin/caddy" "run"
    "--config" "${config.my.servers.caddy.caddyfile}"
    "--adapter" "caddyfile"
  ];

  launchd.user.agents.caddy.serviceConfig.RunAtLoad = true;
  launchd.user.agents.caddy.serviceConfig.KeepAlive = true;
  launchd.user.agents.caddy.serviceConfig.StandardOutPath = config.my.servers.caddy.daemonStandardFile;
  launchd.user.agents.caddy.serviceConfig.StandardErrorPath = config.my.servers.caddy.daemonStandardFile;
  launchd.user.agents.caddy.serviceConfig.EnvironmentVariables.PORKBUN_API_KEY = local.home.kyleerhabor.porkbun.apiKey;
  launchd.user.agents.caddy.serviceConfig.EnvironmentVariables.PORKBUN_SECRET_KEY = local.home.kyleerhabor.porkbun.secretKey;
}
