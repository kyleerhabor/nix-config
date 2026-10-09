{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (finalAttrs: _previousAttrs: {
        version = "1.28.1";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/${finalAttrs.version}/komga-${finalAttrs.version}.jar";
          hash = "sha256-ANW+aVNpjeCtlmuqt9YttAlxxRyBDrTNnxExXDbMouY=";
        };
      });
    })
  ];
}
