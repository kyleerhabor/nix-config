{ config, ... }: {
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

  sops.templates."porkbun-keys.caddyfile".content = ''
    api_key "${config.sops.placeholder.porkbunAPIKey}"
    api_secret_key "${config.sops.placeholder.porkbunSecretKey}"
  '';
  sops.templates."porkbun-keys.caddyfile".owner = config.my.user.name;
  sops.templates."porkbun-keys.caddyfile".mode = "0400";
}
