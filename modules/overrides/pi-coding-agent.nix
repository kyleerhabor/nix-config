{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      pi-coding-agent = final.callPackage ../../packages/pi-coding-agent.nix {};
    })
  ];
}
