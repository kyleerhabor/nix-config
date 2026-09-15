{ config, pkgs, lib, ... }: let
  signer = pkgs.writeShellScriptBin "git-signer" ''
    export SSH_AUTH_SOCK="${config.home.homeDirectory}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    exec ${lib.getExe' pkgs.openssh "ssh-keygen"} "$@"
  '';
in {
  # Enable Git integration.
  programs.git.enable = true;

  # Whether to enable Git Large File Storage.
  programs.git.lfs.enable = true;

  # Configuration written to $XDG_CONFIG_HOME/git/config. See git-config(1) for details.
  programs.git.settings.user.name = "Kyle Erhabor";
  programs.git.settings.user.email = "kyleerhabor@gmail.com";
  programs.git.settings.core.autocrlf = "input";
  programs.git.settings.core.excludesFile = "${./kyleerhabor/resources/git/ignore}";
  programs.git.settings.init.defaultBranch = "main";
  programs.git.settings.gpg.ssh.allowedSignersFile = "${./kyleerhabor/resources/git/allowedsigners}";

  # The signing method to use when signing commits and tags.
  programs.git.signing.format = "ssh";

  # The default signing key fingerprint.
  programs.git.signing.key = "${./kyleerhabor/resources/git/signing.pub}";

  # Path to signer binary to use.
  programs.git.signing.signer = "${signer}/bin/git-signer";

  # Whether commits and tags should be signed by default.
  programs.git.signing.signByDefault = true;

  # Enable Nushell integration.
  programs.nushell.enable = true;
}
