{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      nushell = final.callPackage ../../packages/nushell.nix {};
    })
  ];
}
