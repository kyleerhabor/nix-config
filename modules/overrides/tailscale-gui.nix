{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      # The built-in package's install phase is wrong.
      tailscale-gui = final.callPackage ../../packages/tailscale-gui.nix {};
    })
  ];
}
