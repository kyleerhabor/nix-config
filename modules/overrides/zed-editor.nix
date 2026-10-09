{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      zed-editor = final.callPackage ../../packages/zed-editor.nix {};
    })
  ];
}
