{ stdenvNoCC, fetchzip }: let
  srcVersion = "2026.08.19";
in stdenvNoCC.mkDerivation {
  pname = "yt-dlp";
  version = "2026.08.19";
  src = fetchzip {
    # The binary download unpacks itself on execution, which is slow. This uses the unpacked result.
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${srcVersion}/yt-dlp_macos.zip";
    hash = "sha256-i8SpWGE94DGJjz5a+o2j7JSZhowvryYWnRYFPDBjT+w=";
    stripRoot = false;
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out/libexec/yt-dlp $out/bin
    cp -R $src/_internal $out/libexec/yt-dlp/
    install $src/yt-dlp_macos $out/libexec/yt-dlp/yt-dlp
    ln -s ../libexec/yt-dlp/yt-dlp $out/bin/yt-dlp
    runHook postInstall
  '';
}
