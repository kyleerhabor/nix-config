{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      meta = final.callPackage ../../packages/meta.nix {};
    })
  ];
}
