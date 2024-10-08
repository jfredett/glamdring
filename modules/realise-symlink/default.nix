# An idea taken from https://kokada.capivaras.dev/blog/quick-bits-realise-nix-symlinks/
{ config, lib, pkgs, ... }: with lib; let
  realise-symlink = pkgs.writeShellApplication {
    name = "realise-symlink";
    runtimeInputs = with pkgs; [ coreutils ];
    text = ''
      for file in "$@"; do
        if [[ -L "$file" ]]; then
          if [[ -d "$file" ]]; then
            tmpdir="''${file}.tmp"
            mkdir -p "$tmpdir"
            cp --verbose --recursive "$file"/* "$tmpdir"
            unlink "$file"
            mv "$tmpdir" "$file"
            chmod --changes --recursive +w "$file"
          else
            cp --verbose --remove-destination "$(readlink "$file")" "$file"
            chmod --changes +w "$file"
          fi
        else
          >&2 echo "Not a symlink: $file"
          exit 1
        fi
      done
    '';
  };
in {
  options.glamdring.realise-symlink = {
    enable = mkEnableOption "Enable realise-symlink";
  };

  config = mkIf config.glamdring.realise-symlink.enable {
    home.packages = [ realise-symlink ];
  };
}
