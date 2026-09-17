{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = final.callPackage ../../packages/yt-dlp.nix {};
    })
  ];
}
