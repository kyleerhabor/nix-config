{ stdenvNoCC, fetchurl, unzip }: stdenvNoCC.mkDerivation {
  pname = "macos-trash";
  version = "3.0.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/macos-trash/releases/download/v3.0.0/trash.zip";
    hash = "sha256-GUt1pwIYolbARPUCLUhxHQ8WyCSONMoCETqTtGqhQV8=";
  };
  nativeBuildInputs = [unzip];
  buildCommand = ''
    mkdir -p $out/bin
    unzip -j $src -d $out/bin
  '';
}
