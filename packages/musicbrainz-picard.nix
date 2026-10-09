{ dmgUnpackHook, fetchurl, stdenvNoCC, ... }: stdenvNoCC.mkDerivation (finalAttrs: let
  srcMacosMinimumVersion = "13.0";
  system = stdenvNoCC.hostPlatform.system;
  thrownSystem = throw "Unsupported system";
  url = {
    x86_64-darwin = "https://data.musicbrainz.org/pub/musicbrainz/picard/MusicBrainz-Picard-${finalAttrs.version}-macOS-${srcMacosMinimumVersion}-x86_64.dmg";
  }.${system} or thrownSystem;
  hash = {
    x86_64-darwin = "sha256-decv7ixGLvpjjVhsdS+gUXyViLrYc/ZEpLFk1byvZz8=";
  }.${system} or thrownSystem;
in {
  pname = "picard";
  version = "3.0";
  src = fetchurl {
    inherit url hash;
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "apfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "MusicBrainz Picard.app" $out/Applications/
    runHook postInstall
  '';
})
