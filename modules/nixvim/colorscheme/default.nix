{ config, pkgs, lib, nur, ... }: with lib; {
  imports = [
    ./gruvbox.nix
    ./kanagawa.nix
  ];

  options.glamdring.nixvim.colorscheme = mkOption {
    default = "gruvbox";
    type = types.enum [ "stylix" "kanagawa" "gruvbox" ];
    description = "The colorscheme to use";
  };


  config = let
    cfg = config.glamdring.nixvim.colorscheme;
  in {
    stylix.targets.nixvim.enable = (cfg == "stylix");
  };
}
