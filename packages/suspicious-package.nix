{ dmgUnpackHook, fetchurl, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "suspicious-package";
  version = "4.8";
  src = fetchurl {
    # Internet Archive doesn't like my Mullvad VPN.
    url = "https://www.mothersruin.com/software/archives/SuspiciousPackage-${finalAttrs.version}.dmg";
    hash = "sha256-y+F7GhwdYTfo82RDYihjdzcJ1BXAruxo5Bspzj+tKX8=";
  };
  dontFixup = true;
  nativeBuildInputs = [ dmgUnpackHook ];
  dmgFormat = "hfs";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Suspicious Package.app" $out/Applications/
    runHook postInstall
  '';
})
