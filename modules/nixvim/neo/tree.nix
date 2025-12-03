{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.neo.tree = {
      enable = mkEnableOption "Enable the neotree plugin";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.neo.tree;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.neo-tree = {
          enable = true;

          settings = {
            sort_case_insensitive = true;
            filesystem.filtered_items = {
              hide_gitignored = false;
              hide_by_name = [ "target" "out" ];
            };
          };
        };
      };
    };
}
