{ config, pkgs, lib, ... }: let
  signer = pkgs.writeShellScriptBin "git-signer" ''
    export SSH_AUTH_SOCK="${config.home.homeDirectory}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    exec ${lib.getExe' pkgs.openssh "ssh-keygen"} "$@"
  '';
in {
  # Enable Git integration.
  programs.git.enable = true;

  # Configuration written to $XDG_CONFIG_HOME/git/config. See git-config(1) for details.
  programs.git.settings.user.name = "Kyle Erhabor";
  programs.git.settings.user.email = "kyleerhabor@gmail.com";
  programs.git.settings.core.excludesFile = "${./kyleerhabor/resources/git/ignore}";
  programs.git.settings.gpg.ssh.allowedSignersFile = "${./kyleerhabor/resources/git/allowed_signers}";
  programs.git.signing.format = "ssh";
  programs.git.signing.key = "${./kyleerhabor/resources/git/signing.pub}";
  programs.git.signing.signer = "${signer}/bin/git-signer";
  programs.git.signing.signByDefault = true;

  # Enable Nushell integration.
  programs.nushell.enable = true;
}
