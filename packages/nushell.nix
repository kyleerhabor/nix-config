{ stdenvNoCC, fetchzip }: let
  assets = {
    "x86_64-darwin".url = "https://github.com/nushell/nushell/releases/download/0.114.1/nu-0.114.1-x86_64-apple-darwin.tar.gz";
    "x86_64-darwin".hash = "sha256-y8Q/Et+eN7nqiNudo7dR0LGQgkqIxtT6r1Enp9E6zcA=";
  };
  asset = assets.${stdenvNoCC.hostPlatform.system};
in stdenvNoCC.mkDerivation {
  pname = "nushell";
  version = "0.114.1";
  src = fetchzip {
    inherit (asset) url hash;
  };
  buildCommand = ''
    mkdir -p $out/bin
    install $src/nu* $out/bin/
  '';
}
