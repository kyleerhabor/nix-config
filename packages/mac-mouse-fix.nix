{ stdenvNoCC, fetchzip }: let
  srcVersion = "3.1.0";
in stdenvNoCC.mkDerivation {
  pname = "mac-mouse-fix";
  version = "3.1.0";
  src = fetchzip {
    url = "https://github.com/noah-nuebling/mac-mouse-fix/releases/download/${srcVersion}/MacMouseFixApp.zip";
    hash = "sha256-s9XcaTv0n9Tscoc33WNwS4738KzDb3gHTZ4JWPBg8WE=";
    stripRoot = false;
  };
  buildCommand = ''
    mkdir -p $out/Applications
    cp -R "$src/Mac Mouse Fix.app" $out/Applications/
  '';
}
