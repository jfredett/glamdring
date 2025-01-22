{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.darwin = {
      enable = mkEnableOption "Enable MacOS specific configuration";
    };
  };

  imports = [
    ./amethyst
  ];

  config = let
    cfg = config.glamdring.darwin;
    # NOTE: https://github.com/darwin-org/ghostty/discussions/3800 explains why this is here. In short, 
    # `darwin` needs to be signed, that's nontrivial, work underway, but no ETA.
    condition = !pkgs.stdenv.isLinux && cfg.enable;
  in mkIf condition {
      homebrew.enable = true;
  };
}
