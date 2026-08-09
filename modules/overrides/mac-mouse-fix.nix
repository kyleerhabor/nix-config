{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      mac-mouse-fix = final.callPackage ../../packages/mac-mouse-fix.nix {};
    })
  ];
}
