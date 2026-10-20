{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      suspicious-package = final.callPackage ../../packages/suspicious-package.nix {};
    })
  ];
}
