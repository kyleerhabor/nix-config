{ ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      archaeology = final.callPackage ../../packages/archaeology.nix {};
    })
  ];
}
