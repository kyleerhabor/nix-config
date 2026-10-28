{ fetchzip, lib, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tailscale-gui";
  version = "1.104.4";
  src = fetchzip {
    url = "https://pkgs.tailscale.com/stable/Tailscale-${finalAttrs.version}-macos.zip";
    hash = "sha256-S21B5mDsxGVEENSbAuT8vcT4xecGktz3TwvWWTje6JA=";
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
