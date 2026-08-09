{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      komga = prev.komga.overrideAttrs (old: {
        version = "1.25.0";
        src = final.fetchurl {
          url = "https://github.com/gotson/komga/releases/download/1.25.0/komga-1.25.0.jar";
          sha256 = "sha256-NlL5rBpCFbiZ+HHNoOgLE0Ht3lXXul2qIb8rq9qEzhM=";
        };
      });
    })
  ];
}
