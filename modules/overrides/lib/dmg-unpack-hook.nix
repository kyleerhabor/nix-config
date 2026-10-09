{ ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      dmgUnpackHook = final.callPackage ../../../packages/lib/dmg-unpack-hook.nix {};
    })
  ];
}
