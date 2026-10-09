{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      swish = final.callPackage ../../packages/swish.nix {};
    })
  ];
}
