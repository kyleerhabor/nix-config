{ stdenvNoCC, fetchurl, unzip }: stdenvNoCC.mkDerivation {
  pname = "mac-mouse-fix";
  version = "3.0.8";
  src = fetchurl {
    url = "https://github.com/noah-nuebling/mac-mouse-fix/releases/download/3.0.8/MacMouseFixApp.zip";
    hash = "sha256-2xZORdMLL9Av8SY1rBfFRB6/xUL6795ruGFZanmN+K4=";
  };
  nativeBuildInputs = [unzip];
  buildCommand = ''
    mkdir -p $out/Applications
    unzip -q $src -d $out/Applications
  '';
}
