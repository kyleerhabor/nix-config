{ fetchzip, lib, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tailscale-gui";
  version = "1.104.2";
  src = fetchzip {
    url = "https://pkgs.tailscale.com/stable/Tailscale-${finalAttrs.version}-macos.zip";
    hash = "sha256-U9UwMpRSereutw5GzvbmeJTfpERO+1W5Az8Ig2QcVHc=";
    stripRoot = false;
  };
  dontFixup = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Tailscale.app" $out/Applications/
    runHook postInstall
  '';
  meta.sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
})
