{ config, lib, pkgs, ... }: with lib; {
  config = let
    condition = config.glamdring.nixvim.statusline == "lualine";
  in mkIf condition {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;
      };
    };
  };
}
