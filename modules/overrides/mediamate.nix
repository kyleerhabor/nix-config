{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      mediamate = final.callPackage ../../packages/mediamate.nix {};
    })
  ];
}
