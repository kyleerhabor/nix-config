{ ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      apparency = final.callPackage ../../packages/apparency.nix {};
    })
  ];
}
