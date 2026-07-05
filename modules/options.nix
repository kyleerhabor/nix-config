{ config, lib, pkgs, ... }: {
  options.my.user = lib.mkOption {
    type = lib.types.submodule {
      options.name = lib.mkOption { type = lib.types.str; };
      options.directories = lib.mkOption {
        type = lib.types.submodule {
          options.home = lib.mkOption {
            type = lib.types.str;
            default = "/Users/${config.my.user.name}";
          };
          options.logs = lib.mkOption {
            type = lib.types.str;
            default = "${config.my.user.directories.home}/Library/Logs";
          };
        };
        default = {};
      };
    };
    default = {};
  };
  options.my.servers = lib.mkOption {
    type = lib.types.submodule {
      options.navidrome = lib.mkOption {
        type = lib.types.submodule {
          options.configurationFile = lib.mkOption { type = lib.types.path; };
          options.daemonID = lib.mkOption {
            type = lib.types.str;
            default = "com.kyleerhabor.nix-config.navidrome";
          };
          options.daemonStandardFile = lib.mkOption {
            type = lib.types.str;
            default = "${config.my.user.directories.logs}/${config.my.servers.navidrome.daemonID}.log";
          };
          options.package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.navidrome;
          };
        };
        default = {};
      };
      options.komga = lib.mkOption {
        type = lib.types.submodule {
          options.package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.komga;
          };
          options.daemonID = lib.mkOption {
            type = lib.types.str;
            default = "com.kyleerhabor.nix-config.komga";
          };
        };
        default = {};
      };
      options.caddy = lib.mkOption {
        type = lib.types.submodule {
          options.caddyfile = lib.mkOption { type = lib.types.path; };
          options.daemonID = lib.mkOption {
            type = lib.types.str;
            default = "com.kyleerhabor.nix-config.caddy";
          };
          options.daemonStandardFile = lib.mkOption {
            type = lib.types.str;
            default = "${config.my.user.directories.logs}/${config.my.servers.caddy.daemonID}.log";
          };
          options.package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.caddy.withPlugins {
              plugins = ["github.com/caddy-dns/porkbun@v0.3.1"];
              hash = "sha256-JtzeWz9GdW/+1Qft5nU9diPkFQvPGxQkgR8n8w+ryoI=";
            };
          };
        };
        default = {};
      };
    };
    default = {};
  };
}
