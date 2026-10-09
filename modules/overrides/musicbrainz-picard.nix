{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      picard = final.callPackage ../../packages/musicbrainz-picard.nix {};
    })
  ];
}
