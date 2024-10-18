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
        sortCaseInsensitive = true;
        filesystem.filteredItems = {
          hideGitignored = false;
          hideByName = [ "target" "out" ];
        };
      };
    };
  };
}
