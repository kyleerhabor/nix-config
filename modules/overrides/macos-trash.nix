{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      macos-trash = final.callPackage ../../packages/macos-trash.nix {};
    })
  ];
}
