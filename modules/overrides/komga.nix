{ ... }: let
  srcVersion = "1.27.0";
in {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (old: {
        version = "1.27.0";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/${srcVersion}/komga-${srcVersion}.jar";
          sha256 = "sha256-B5NyJJD9aY7R/VYzd90TGck0OkTK/fRZUAik0zJFbJs=";
        };
      });
    })
  ];
}
