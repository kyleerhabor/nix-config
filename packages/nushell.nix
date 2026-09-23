{ stdenvNoCC, fetchzip }: let
  assetVersion = "0.115.1";
  assets = {
    "x86_64-darwin".url = "https://github.com/nushell/nushell/releases/download/${assetVersion}/nu-${assetVersion}-x86_64-apple-darwin.tar.gz";
    "x86_64-darwin".hash = "sha256-gBXcL7IypMAn01+WzPmZPXVMStmezlY4VJnjtLwbK6Q=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "nushell";
  version = "0.115.1";
  src = fetchzip {
    inherit (asset) url hash;
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install $src/nu* $out/bin/
    runHook postInstall
  '';
}
