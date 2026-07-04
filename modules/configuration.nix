{ pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # python313 exists, but I can't use pip to install packages, which is bad for packages like yt-dlp which regularly update.
  environment.systemPackages = with pkgs; [
    (clojure.override { jdk = jdk25_headless; })
    fastfetch
    ffmpeg-full
    lua54Packages.fennel
    mediainfo
    mpv
    neovim-unwrapped
    nixd
    nodejs_latest # TODO: Move to project configuration.
    nushell
    pyenv
    rustup
    smartmontools
    sqlitebrowser
    tree
    vscode
  ];

  # Enable System Settings > Network > Firewall.
  networking.applicationFirewall.enable = true;

  # Allow built-in software to receive incoming connections.
  networking.applicationFirewall.allowSigned = true;

  # Allow downloaded signed software to receive incoming connections.
  networking.applicationFirewall.allowSignedApp = true;

  # Automatically run the nix store garbage collector (releasing).
  nix.gc.automatic = true;

  # Automatically run the nix store optimizer (compacting).
  nix.optimise.automatic = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Enable showing keystrokes when using sudo.
  security.sudo.extraConfig = "Defaults pwfeedback";

  # Enable using Touch ID for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable Homebrew integration.
  homebrew.enable = true;
  homebrew.brews = [
    {
      name = "macos-trash";
    }
  ];

  homebrew.casks = [
    {
      # For some reason, calibre from Nixpkgs is unsupported on Darwin:
      #
      #   Refusing to evaluate package 'qtwayland-6.11.0' in [...] because it is not available on the requested hostPlatform
      name = "calibre";
    }
    {
      name = "mac-mouse-fix";
    }
  ];
}
