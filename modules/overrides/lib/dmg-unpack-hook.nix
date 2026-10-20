{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      dmgUnpackHook = final.callPackage ../../../packages/lib/dmg-unpack-hook.nix {};
    })
  ];
}
