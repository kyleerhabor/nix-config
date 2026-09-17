{ config, lib, pkgs, ... }: {
  options.my.apps.transmission = lib.mkOption {
    type = lib.types.submodule {
      options.bundleID = lib.mkOption {
        type = lib.types.str;
        default = "org.m0k.transmission";
      };
      options.bindAddressIPv4 = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
    default = {};
  };
  options.my.user = lib.mkOption {
    type = lib.types.submodule {
      options.name = lib.mkOption { type = lib.types.str; };
      options.paths = lib.mkOption {
        type = lib.types.submodule {
          options.home = lib.mkOption {
            type = lib.types.str;
            default = "/Users/${config.my.user.name}";
          };
          options.logs = lib.mkOption {
            type = lib.types.str;
            default = "${config.my.user.paths.home}/Library/Logs";
          };
          options.sopsAgeKey = lib.mkOption {
            type = lib.types.str;
            default =  "${config.my.user.paths.home}/Library/Application Support/sops/age/keys.txt";
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
            default = "${config.my.user.paths.logs}/${config.my.servers.navidrome.daemonID}.log";
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
          options.configurationFile = lib.mkOption { type = lib.types.path; };
          options.daemonID = lib.mkOption {
            type = lib.types.str;
            default = "com.kyleerhabor.nix-config.komga";
          };
          options.package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.komga;
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
            default = "${config.my.user.paths.logs}/${config.my.servers.caddy.daemonID}.log";
          };
          options.package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.caddy.withPlugins {
              plugins = ["github.com/caddy-dns/porkbun@v0.3.1"];
              hash = "sha256-iFuoa6k2r3jUPazHHujhB4bBq3Fz0Mv0Tjsr+gxMYQQ=";
            };
          };
        };
        default = {};
      };
    };
    default = {};
  };
}
