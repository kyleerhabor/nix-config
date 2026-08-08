{ lib, stdenvNoCC, fetchurl, makeWrapper, ripgrep, fd }: let
  assets = {
    # In the future, I may add support for Apple silicon.
    "x86_64-darwin".url = "https://github.com/earendil-works/pi/releases/download/v0.84.1/pi-darwin-x64.tar.gz";
    "x86_64-darwin".hash = "sha256-+QYJYrnMpUONf7l7YK2unJMCUD05to2K6ouJHi6z54Y=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "pi-coding-agent";
  version = "0.84.1";
  src = fetchurl {
    inherit (asset) url hash;
  };
  nativeBuildInputs = [makeWrapper];
  buildCommand = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out
    makeWrapper $out/pi/pi $out/bin/pi \
      --prefix PATH : ${lib.makeBinPath [ ripgrep fd ]}
  '';
}
