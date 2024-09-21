{ config, lib, pkgs, ... }: with lib; {
  config = let
    cfg = config.glamdring.nixvim.colorscheme;
    condition = cfg == "gruvbox";
  in mkIf condition {
    programs.nixvim.colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrastDark = "hard";
        italics = 1;
        bold = 1;
        term_colors = 256;
        trueColor = true;
      };
    };
  };
}
