{ pkgs, ... }: let
  # I don't see a way to include secrets without requiring impure evaluation.
  local = import /Users/kyleerhabor/.config/nix-config/local.nix;
  gitignore = pkgs.writeText "global-gitignore" (builtins.readFile ./kyleerhabor/resources/git/ignore);
  navidromeConfigurationFile = pkgs.writeText "navidrome.toml" (builtins.readFile ./kyleerhabor/resources/navidrome/navidrome.toml);
  caddyfile = pkgs.writeText "Caddyfile" (builtins.readFile ./kyleerhabor/resources/caddy/Caddyfile);
  organizationID = "com.kyleerhabor";

  # Paths
  homeDirectory = "/Users/kyleerhabor";
  logDirectory = "${homeDirectory}/Library/Logs";

  # Daemons
  navidromeDaemonID = "${organizationID}.nix-config.navidrome";
  navidromeDaemonStandardFile = "${logDirectory}/${navidromeDaemonID}.log";
  komgaDaemonID = "${organizationID}.nix-config.komga";
  caddyDaemonID = "${organizationID}.nix-config.caddy";
  caddyDaemonStandardFile = "${logDirectory}/${caddyDaemonID}.log";

  # Packages
  caddy = pkgs.caddy.withPlugins {
    plugins = ["github.com/caddy-dns/porkbun@v0.3.1"];
    hash = "sha256-JtzeWz9GdW/+1Qft5nU9diPkFQvPGxQkgR8n8w+ryoI=";
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

  # Navidrome (4533)
  launchd.agents.navidrome.enable = true;
  launchd.agents.navidrome.config.Label = navidromeDaemonID;
  launchd.agents.navidrome.config.ProgramArguments = [
    "${pkgs.navidrome}/bin/navidrome"
    "--configfile" "${navidromeConfigurationFile}"
  ];

  launchd.agents.navidrome.config.RunAtLoad = true;
  launchd.agents.navidrome.config.KeepAlive = true;
  launchd.agents.navidrome.config.StandardOutPath = navidromeDaemonStandardFile;
  launchd.agents.navidrome.config.StandardErrorPath = navidromeDaemonStandardFile;

  # Komga (25600)
  launchd.agents.komga.enable = true;
  launchd.agents.komga.config.Label = komgaDaemonID;
  launchd.agents.komga.config.ProgramArguments = [
    "${pkgs.komga}/bin/komga"
  ];

  launchd.agents.komga.config.RunAtLoad = true;
  launchd.agents.komga.config.KeepAlive = true;

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
  launchd.agents.caddy.config.EnvironmentVariables.PORKBUN_API_KEY = local.home.kyleerhabor.porkbun.apiKey;
  launchd.agents.caddy.config.EnvironmentVariables.PORKBUN_SECRET_KEY = local.home.kyleerhabor.porkbun.secretKey;
}
