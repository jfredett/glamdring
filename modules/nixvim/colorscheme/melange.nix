{ config, lib, ... }: with lib; {
  config = let
    cfg = config.glamdring.nixvim.colorscheme;
    condition = cfg == "melange";
  in mkIf condition {
    programs.nixvim.colorschemes.melange = {
      enable = true;
    };
  };
}
