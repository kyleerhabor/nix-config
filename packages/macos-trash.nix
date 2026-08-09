{ stdenvNoCC, fetchzip }: stdenvNoCC.mkDerivation {
  pname = "macos-trash";
  version = "3.0.0";
  src = fetchzip {
    url = "https://github.com/sindresorhus/macos-trash/releases/download/v3.0.0/trash.zip";
    hash = "sha256-EUCLgp35Ur+n9HcmwzzLZFIsAyrWCtBGS+CwpF4Oqns=";
  };
  buildCommand = ''
    mkdir -p $out/bin
    install $src/trash $out/bin/trash
  '';
}
