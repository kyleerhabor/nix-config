{ dmgUnpackHook, fetchurl, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: let
  system = stdenvNoCC.hostPlatform.system;
  thrownSystem = throw "Unsupported system: ${system}";
  url = {
    x86_64-darwin = "https://github.com/zed-industries/zed/releases/download/v${finalAttrs.version}/Zed-x86_64.dmg";
  }.${system} or thrownSystem;
  hash = {
    x86_64-darwin = "sha256-YdKsr9HaEm1vB8xuXZM/mq/rUfPp3qSK2i1DOy7ua4Q=";
  }.${system} or thrownSystem;
in {
  pname = "zed-editor";
  version = "1.23.2";
  src = fetchurl {
    inherit url hash;
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "apfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Zed.app" $out/Applications/
    runHook postInstall
  '';
})
