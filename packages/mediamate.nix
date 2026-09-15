{ stdenvNoCC, fetchzip }: let
  srcVersion = "v3.8.4";
  srcBuild = "321";
in stdenvNoCC.mkDerivation {
  pname = "mediamate";
  version = "3.8.4";
  src = fetchzip {
    url = "https://github.com/Wouter01/MediaMate-Releases/releases/download/${srcVersion}_${srcBuild}/MediaMate_${srcVersion}-${srcBuild}.zip";
    hash = "sha256-WQMugby+HvZL1VwZQsY4/dnovN5sX+7tBbb1Tzkaack=";
    stripRoot = false;
  };
  buildCommand = ''
    mkdir -p $out/Applications
    cp -R "$src/MediaMate.app" $out/Applications/
  '';
}
