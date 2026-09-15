{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      libjxl_0_12 = final.callPackage ../../packages/libjxl-0.12.nix {};
    })
  ];
}
