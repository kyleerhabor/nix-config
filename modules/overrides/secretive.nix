{ ... }: let
  srcVersion = "v4.0.0";
in {
  nixpkgs.overlays = [
    (final: prev: {
      secretive = prev.secretive.overrideAttrs (old: {
        version = "4.0.0";
        src = final.fetchzip {
          url = "https://github.com/maxgoedjen/secretive/releases/download/${srcVersion}/Secretive.zip";
          hash = "sha256-AP/ubwV9h/9EYj7J6psSUAkzBjee3QB3a4/7hv7nWYk=";
          stripRoot = false;
        };
      });
    })
  ];
}
