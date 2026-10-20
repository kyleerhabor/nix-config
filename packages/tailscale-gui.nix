{ fetchzip, lib, stdenvNoCC }: stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tailscale-gui";
  version = "1.104.1";
  src = fetchzip {
    url = "https://pkgs.tailscale.com/stable/Tailscale-${finalAttrs.version}-macos.zip";
    hash = "sha256-4ebA9YBDQEbmtG71xbbk3o3zZkDqH9YE3sAiDvIHlEY=";
    stripRoot = false;
  };
  dontFixup = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    mkdir -p $out/bin
    cp -R "Tailscale.app" $out/Applications/
    ln -s "$out/Applications/Tailscale.app/Contents/MacOS/Tailscale" "$out/bin/tailscale"
    runHook postInstall
  '';
  meta.sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
})
