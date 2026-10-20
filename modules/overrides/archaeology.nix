{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      archaeology = final.callPackage ../../packages/archaeology.nix {};
    })
  ];
}
