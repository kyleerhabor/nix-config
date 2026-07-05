{ config, ... }: let
  # I don't see a way to include secrets without requiring impure evaluation.
  # navidrome = pkgs.writeText "navidrome.toml" (builtins.readFile ../resources/hosts/kyles-macbook-pro/navidrome/navidrome.toml);
  # caddyfile = pkgs.writeText "Caddyfile" (builtins.readFile ../resources/hosts/kyles-macbook-pro/caddy/Caddyfile);
in {
  my.user.name = "kyleerhabor";
  my.servers.navidrome.configurationFile = ./kyles-macbook-pro/servers/navidrome/resources/navidrome.toml;
  my.servers.caddy.caddyfile = ./kyles-macbook-pro/servers/caddy/resources/Caddyfile;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "x86_64-darwin";

  # Homebrew
  system.primaryUser = config.my.user.name;

  users.users.kyleerhabor.name = config.my.user.name;
  users.users.kyleerhabor.home = config.my.user.directories.home;

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.kyleerhabor = { ... }: {
    # Backwards compatibility for Home Manager.
    home.stateVersion = "25.11";
    imports = [../home/kyleerhabor.nix];
  };

  imports = [
    ./kyles-macbook-pro/servers/navidrome.nix  # 4533
    ./kyles-macbook-pro/servers/komga.nix      # 25600
    ./kyles-macbook-pro/servers/caddy.nix
  ];
}
