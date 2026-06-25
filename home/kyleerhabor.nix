{ pkgs, ... }: let
  gitignore = pkgs.writeText "global-gitignore" (builtins.readFile ./kyleerhabor/resources/git/ignore);
  caddyfile = pkgs.writeText "Caddyfile" (builtins.readFile ./kyleerhabor/resources/caddy/Caddyfile);
  organizationID = "com.kyleerhabor";

  # Paths
  homeDirectory = "/Users/kyleerhabor";
  logDirectory = "${homeDirectory}/Library/Logs";

  # Daemons
  caddyDaemonID = "${organizationID}.caddy";
  caddyDaemonStandardFile = "${logDirectory}/${caddyDaemonID}.log";

  # Packages
  caddy = pkgs.caddy.withPlugins {
    plugins = ["github.com/caddy-dns/porkbun@v0.3.1"];
    hash = "sha256-MlKX2obWac+jP4j9UHFMxsY/DRaqw9JCVAdI7erhFwo=";
  };
in {
  # Enable Git integration.
  programs.git.enable = true;

  # Configuration written to $XDG_CONFIG_HOME/git/config. See git-config(1) for details.
  programs.git.settings.user.name = "Kyle Erhabor";
  programs.git.settings.user.email = "kyleerhabor@gmail.com";
  programs.git.settings.core.excludesFile = "${gitignore}";

  # Enable Nushell integration.
  programs.nushell.enable = true;

  # Caddy
  launchd.agents.caddy.enable = true;
  launchd.agents.caddy.config.Label = caddyDaemonID;
  launchd.agents.caddy.config.ProgramArguments = [
    "${caddy}/bin/caddy" "run"
    "--config" "${caddyfile}"
    "--adapter" "caddyfile"
  ];

  launchd.agents.caddy.config.RunAtLoad = true;
  launchd.agents.caddy.config.KeepAlive = true;
  launchd.agents.caddy.config.StandardOutPath = caddyDaemonStandardFile;
  launchd.agents.caddy.config.StandardErrorPath = caddyDaemonStandardFile;
}
