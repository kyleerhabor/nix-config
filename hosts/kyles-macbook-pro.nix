{ config, pkgs, ... }: let
  porkbunSOPSFile = ./kyles-macbook-pro/secrets/porkbun.yaml;
in {
  my.apps.transmission.bindAddressIPv4 = "10.74.58.18";
  my.user.name = "kyleerhabor";
  my.servers.caddy.caddyfile = ./kyles-macbook-pro/servers/caddy/resources/Caddyfile;
  my.servers.komga.configurationFile = ./kyles-macbook-pro/servers/komga/resources/application.yml;
  my.servers.navidrome.configurationFile = ./kyles-macbook-pro/servers/navidrome/resources/navidrome.toml;

  environment.systemPackages = with pkgs; [libjxl_0_12];

  sops.age.keyFile = config.my.user.paths.sopsAgeKey;
  sops.age.sshKeyPaths = [];
  sops.gnupg.sshKeyPaths = [];
  sops.secrets.porkbunAPIKey.sopsFile = porkbunSOPSFile;
  sops.secrets.porkbunAPIKey.key = "api_key";
  sops.secrets.porkbunAPIKey.owner = config.my.user.name;
  sops.secrets.porkbunSecretKey.sopsFile = porkbunSOPSFile;
  sops.secrets.porkbunSecretKey.key = "secret_key";
  sops.secrets.porkbunSecretKey.owner = config.my.user.name;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "x86_64-darwin";

  # Homebrew
  system.primaryUser = config.my.user.name;

  users.users.kyleerhabor.name = config.my.user.name;
  users.users.kyleerhabor.home = config.my.user.paths.home;

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.kyleerhabor = { ... }: {
    # The state version indicates which default settings are in effect and will therefore help avoid breaking program
    # configurations.
    home.stateVersion = "25.11";

    imports = [../home/kyleerhabor.nix];
  };

  imports = [
    ../modules/overrides/komga.nix
    ../modules/overrides/libjxl-0.12.nix
    ../modules/overrides/mediamate.nix
    ../modules/overrides/nushell.nix
    ../modules/overrides/pi-coding-agent.nix
    ../modules/overrides/yt-dlp.nix
    ./kyles-macbook-pro/servers/caddy.nix
    ./kyles-macbook-pro/servers/komga.nix
    ./kyles-macbook-pro/servers/navidrome.nix
  ];
}
