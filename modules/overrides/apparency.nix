{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      apparency = final.callPackage ../../packages/apparency.nix {};
    })
  ];
}
