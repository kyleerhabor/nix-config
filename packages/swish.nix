{ dmgUnpackHook, fetchurl, stdenvNoCC, ... }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "swish";
  version = "1.13.3";
  src = fetchurl {
    url = "https://github.com/chrenn/swish-dl/releases/download/${finalAttrs.version}/Swish.dmg";
    hash = "sha256-jpaEVNt2F7aik/Pg5VHCFMWqhvRDvGabPhMWEUoY1Sw=";
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "apfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Swish.app" $out/Applications/
    runHook postInstall
  '';
})
