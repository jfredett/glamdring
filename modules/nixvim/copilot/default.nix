{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.copilot = {
      enable = mkEnableOption "Enable Copilot";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.copilot;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      extraPlugins = [ pkgs.vimPlugins.copilot-vim ];
      extraConfigLua = ''
        vim.g.copilot_workspace_folders = {
          "~/code", "/storage/code"
        }
      '';
    };
  };
}
