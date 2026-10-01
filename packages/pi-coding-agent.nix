{ lib, stdenvNoCC, fetchzip, makeWrapper, ripgrep, fd }: let
  srcVersion = "v0.99.2";
  assets = {
    "x86_64-darwin".url = "https://github.com/earendil-works/pi/releases/download/${srcVersion}/pi-darwin-x64.tar.gz";
    "x86_64-darwin".hash = "sha256-GZpR6mMPI+15rifTjMzp6W/oJTeiMI3h2gQMa6K3t/c=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "pi-coding-agent";
  version = "0.99.2";
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
