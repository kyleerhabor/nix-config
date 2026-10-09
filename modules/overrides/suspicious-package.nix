{ ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      suspicious-package = final.callPackage ../../packages/suspicious-package.nix {};
    })
  ];
}
