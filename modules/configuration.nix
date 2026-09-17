{ config, pkgs, inputs, ... }: {
  # TODO: Figure out how to suppress this warning:
  #
  #   evaluation warning: Nixpkgs 26.05 will be the last release to support x86_64-darwin; see
  #   https://nixos.org/manual/nixpkgs/unstable/release-notes#x86_64-darwin-26.05
  #
  # For some reason, setting nixpkgs.config.allowDeprecatedx86_64Darwin = true; doesn't work.

  # List of directories to be symlinked in /run/current-system/sw.
  environment.pathsToLink = ["/share/lua"];

  # The set of packages that appear in /run/current-system/sw.
  #
  # We can't include dependencies that are packaged as DMG because there is no public API for Nix (hdiutil is
  # unavailable in Nix, undmg reverse engineers the format, etc.).
  environment.systemPackages = with pkgs; [
    age
    ffmpeg-full
    lua54Packages.fennel
    mac-mouse-fix
    macos-trash
    mediamate
    mpv
    nushell
    opus-tools
    pi-coding-agent
    secretive

    # Legacy
    (clojure.override { jdk = jdk25_headless; })
    fastfetch
    mediainfo
    neovim-unwrapped
    nixd
    nodejs_latest # TODO: Move to project configuration.
    pyenv
    rustup
    smartmontools
    sqlitebrowser
    tree
    vscode
  ];

  # Whether to enable nix-darwin to manage installing/updating/upgrading Homebrew taps, formulae, casks, Mac App Store
  # apps, Visual Studio Code extensions, Go packages, and Cargo crates using Homebrew Bundle.
  homebrew.enable = true;

  # List of Homebrew casks to install.
  homebrew.casks = [
    {
      # Calibre is packaged as DMG.
      name = "calibre";
    }
    {
      # MusicBrainz Picard is packaged as DMG.
      name = "musicbrainz-picard";
    }
    {
      # OnyX is packaged as DMG.
      name = "onyx";
    }
    {
      # Shottr is packaged as DMG.
      name = "shottr";
    }
    {
      # Suspicious Package is packaged as DMG.
      name = "suspicious-package";
    }
    {
      # EtreCheckPro is packaged as DMG.
      name = "etrecheckpro";
    }
  ];

  # Whether to allow unfree packages.
  #
  # We could use allowUnfreePackages, but given that we're not distributing, it's simpler to allow all unfree software.
  nixpkgs.config.allowUnfree = true;

  # Specify how to handle packages with problems.
  nixpkgs.config.problems.handlers.navidrome.broken = "warn";

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

  imports = [
    ./overrides/mac-mouse-fix.nix
    ./overrides/macos-trash.nix
    ./overrides/mpv.nix
  ];
}
