{ dmgUnpackHook, fetchurl, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "archaeology";
  version = "1.7";
  src = fetchurl {
    # Internet Archive doesn't like my Mullvad VPN.
    url = "https://www.mothersruin.com/software/archives/Archaeology-${finalAttrs.version}.dmg";
    hash = "sha256-m9ue6nKEnnQFR6njcRoC/W9OTUxZqVTi3OogkKKCjVg=";
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "hfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Archaeology.app" $out/Applications/
    runHook postInstall
  '';
})
