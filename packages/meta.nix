{ fetchzip, stdenvNoCC }: let
  srcVersion = "2.5.9";
in stdenvNoCC.mkDerivation {
  pname = "meta";
  version = "2.5.9";
  src = fetchzip {
    url = "https://www.nightbirdsevolve.com/meta/updates/bin/Meta%20${srcVersion}.zip";
    hash = "sha256-naQCS+cxlWbCeO1dSlPLHvA3YGYmeV3BkP4n6iDjX6M=";
    stripRoot = false;
    postFetch = ''
      find $out -type f -name '._*' -delete
    '';
  };
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R "$src/Meta.app" "$out/Applications/"
    runHook postInstall
  '';
}
