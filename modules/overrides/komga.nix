{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (finalAttrs: previousAttrs: {
        version = "1.29.1";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/${finalAttrs.version}/komga-${finalAttrs.version}.jar";
          hash = "sha256-6cr64extDRF8I3X/+ey3N+04Tu3ir+qXFry1VdluqDQ=";
        };
      });
    })
  ];
}
