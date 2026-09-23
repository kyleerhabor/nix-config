{ stdenvNoCC, fetchzip }: let
  srcVersion = "v3.1.0";
in stdenvNoCC.mkDerivation {
  pname = "macos-trash";
  version = "3.1.0";
  src = fetchzip {
    url = "https://github.com/sindresorhus/macos-trash/releases/download/${srcVersion}/trash.zip";
    hash = "sha256-e3sEsAPqsJFrFNlxWU4G65xnW+ZnUFXiE7TOspu9E1U=";
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install $src/trash $out/bin/trash
    runHook postInstall
  '';
}
