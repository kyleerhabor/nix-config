{ ... }: let
  srcVersion = "1.27.1";
in {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (old: {
        version = "1.27.1";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/${srcVersion}/komga-${srcVersion}.jar";
          hash = "sha256-DYfztcP3HjMdNX/BlMc4H9pNB/UYBIFKpGdWjcXR7WU=";
        };
      });
    })
  ];
}
