  { _7zz, lib, writeTextFile }: writeTextFile {
    name = "dmg-unpack-hook";
    destination = "/nix-support/setup-hook";
    text = ''
      _tryUnpackDmgSigned() {
        if [ "$curSrc" = "''${curSrc%.dmg}" ]; then
            return 1
        fi

        case "''${dmgFormat:-}" in
          hfs)
            # The payload lives under the volume's named root directory, which unpackPhase's single-directory detection
            # picks up as sourceRoot.
            ;;
          apfs)
            # No named volume root, so the payload is already at the extract root. Default sourceRoot only if the
            # package did not set one.
            : "''${sourceRoot:=.}"
            ;;
          *)
            echo "dmg-unpack-hook: set dmgFormat to 'hfs' or 'apfs' for $curSrc" >&2
            exit 1
            ;;
        esac

        ${lib.getExe' _7zz "7zz"} x -sns- -snld10 "$curSrc"
      }

      unpackCmdHooks+=(_tryUnpackDmgSigned)
    '';
  }
