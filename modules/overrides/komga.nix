{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (old: {
        version = "1.26.3";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/1.26.3/komga-1.26.3.jar";
          sha256 = "sha256-FjyxwUU8xwuNfLFES20aVRWIbhz0k7sSfvZ+VNbzeSc=";
        };
      });
    })
  ];
}
