{ ... }: let
  srcVersion = "1.28.0";
in {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (old: {
        version = "1.28.0";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/${srcVersion}/komga-${srcVersion}.jar";
          hash = "sha256-3+KO7x1S1oLWUMl7Gp42StZcG0jTmC4Po4HAT9q/OrE=";
        };
      });
    })
  ];
}
