{ dmgUnpackHook, fetchurl, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "apparency";
  version = "3.4";
  src = fetchurl {
    # Internet Archive doesn't like my Mullvad VPN.
    url = "https://www.mothersruin.com/software/archives/Apparency-${finalAttrs.version}.dmg";
    hash = "sha256-Z16t+zNYnjzm6siCZchlHwLC23TayFNh8gNLyVbo/GE=";
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "hfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Apparency.app" $out/Applications/
    runHook postInstall
  '';
})
