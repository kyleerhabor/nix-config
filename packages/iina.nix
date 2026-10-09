{ dmgUnpackHook, fetchurl, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "iina";
  version = "1.5.0";
  src = fetchurl {
    url = "https://dl.iina.io/IINA.v${finalAttrs.version}.dmg";
    hash = "sha256-j61QR5sQ4JZFBTRXzsRr1T0FTO0iQs/mj3RYZzWiDcc=";
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "hfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "IINA.app" $out/Applications/
    runHook postInstall
  '';
})
