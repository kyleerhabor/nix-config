{ lib, stdenvNoCC, fetchzip, makeWrapper, ripgrep, fd }: let
  assets = {
    "x86_64-darwin".url = "https://github.com/earendil-works/pi/releases/download/v0.84.1/pi-darwin-x64.tar.gz";
    "x86_64-darwin".hash = "sha256-fVYQQjO4YZZR7kXwiFCxlCNmwbHlDJYrkH6kkzO4hAQ=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "pi-coding-agent";
  version = "0.84.1";
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
