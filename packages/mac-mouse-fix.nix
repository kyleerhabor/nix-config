{ stdenvNoCC, fetchzip }: stdenvNoCC.mkDerivation {
  pname = "mac-mouse-fix";
  version = "3.0.8";
  src = fetchzip {
    url = "https://github.com/noah-nuebling/mac-mouse-fix/releases/download/3.0.8/MacMouseFixApp.zip";
    hash = "sha256-yqOxnhrceYoT46KGpk+nzFTgwOCtL9hGpu/ifUO0E6A=";
    stripRoot = false;
  };
  buildCommand = ''
    mkdir -p $out/Applications
    cp -R "$src/Mac Mouse Fix.app" $out/Applications/
  '';
}
