{ lib, stdenvNoCC, fetchzip, makeWrapper, ripgrep, fd }: let
  assets = {
    "x86_64-darwin".url = "https://github.com/earendil-works/pi/releases/download/v0.85.1/pi-darwin-x64.tar.gz";
    "x86_64-darwin".hash = "sha256-MH2DmVhE8wCSidzccYJNJkr61HJx2at24qfEflnRBHw=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "pi-coding-agent";
  version = "0.85.1";
  src = fetchzip {
    inherit (asset) url hash;
  };
  nativeBuildInputs = [makeWrapper];
  buildCommand = ''
    mkdir -p $out/bin
    makeWrapper $src/pi $out/bin/pi \
      --prefix PATH : ${lib.makeBinPath [ripgrep fd]}
  '';
}
