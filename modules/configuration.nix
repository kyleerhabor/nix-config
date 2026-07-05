{ config, pkgs, inputs, ... }: {
  # TODO: Figure out how to suppress this warning:
  #
  #   evaluation warning: Nixpkgs 26.05 will be the last release to support x86_64-darwin; see
  #   https://nixos.org/manual/nixpkgs/unstable/release-notes#x86_64-darwin-26.05
  #
  # For some reason, setting nixpkgs.config.allowUnsupportedSystem = true; doesn't work.
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

  # python313 exists, but I can't use pip to install packages, which is bad for packages like yt-dlp which update frequently.
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

  # System Defaults
  #
  # This should be limited to options the user can't set in the system UI.

  # Sets the speed of the autohide delay.
  system.defaults.dock.autohide-delay = 0.0;

  # Disable highlight hover effect for the grid view of a stack in the Dock.
  system.defaults.dock.mouse-over-hilite-stack = false;

  # Whether to show icons on the desktop or not.
  system.defaults.finder.CreateDesktop = false;

  # Whether to allow quitting of the Finder.
  system.defaults.finder.QuitMenuItem = true;

  # Resize columns to fit filenames.
  system.defaults.finder._FXEnableColumnAutoSizing = true;

  # etc.
  system.defaults.CustomUserPreferences."com.apple.Safari".FindOnPageMatchesWordStartsOnly = false;
  system.defaults.CustomUserPreferences."${config.my.apps.transmission.bundleID}".BindAddressIPv4 = config.my.apps.transmission.bindAddressIPv4;
  system.defaults.CustomUserPreferences.NSGlobalDomain.NSZoomButtonShowMenu = false;

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
