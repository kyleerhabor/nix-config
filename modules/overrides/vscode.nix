{ ... }: let
  throwSystem = system: throw "Unsupported system: ${system}";
  srcVersion = "1.140.0";
  platformFor = system: {
    x86_64-darwin = "darwin";
  }.${system} or (throwSystem system);
  # https://github.com/NixOS/nixpkgs/blob/825e2028c29b702a4a5f085f08095d12099784f2/pkgs/applications/editors/vscode/vscode.nix#L73
  nameFor = platform: "VSCode_${srcVersion}_${platform}.zip";
  # https://code.visualstudio.com/docs/supporting/faq#_vs-code-versions
  urlFor = system: platform: "https://update.code.visualstudio.com/${srcVersion}/${platform}/stable";
  hashFor = system: {
    x86_64-darwin = "sha256-X1buYJVoZdeXEd2KHO732UtyuixVOaHkZkLbB6PSVtI=";
  }.${system} or (throwSystem system);
  ripgrepFor = system: {
    x86_64-darwin = "Contents/Resources/app/node_modules.asar.unpacked/@vscode/ripgrep-universal/bin/darwin-x64/rg";
  }.${system} or (throwSystem system);
in {
  nixpkgs.overlays = [
    (final: prev: let
      system = final.stdenv.hostPlatform.system;
      platform = platformFor system;
    in {
      vscode = prev.vscode.overrideAttrs {
        version = "1.140.0";
        src = final.fetchurl {
          name = nameFor platform;
          url = urlFor system platform;
          hash = hashFor system;
        };
        # https://github.com/NixOS/nixpkgs/blob/825e2028c29b702a4a5f085f08095d12099784f2/pkgs/applications/editors/vscode/generic.nix#L408-L428
        postPatch = ''
          chmod +x "${ripgrepFor system}"
        '';
      };
    })
  ];
}
