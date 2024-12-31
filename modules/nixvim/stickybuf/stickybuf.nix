{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.stickybuf = {
      enable = mkEnableOption "Enable stickybufs";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.stickybuf;
    condition = cfg.enable;
    stickybuf = pkgs.vimUtils.buildVimPlugin {
      name = "stickybuf";
      src = pkgs.fetchFromGitHub {
        owner = "stevearc";
        repo = "stickybuf.nvim";
        rev = "183b9569bef78f44b17c078214f7d731f19cbefe";
        sha256 = "sha256-yVXfpUjYYbvuoKL2DhZa7CyOZirVkyn7z0jqytkj+WI=";
      };
    };
  in mkIf condition {
      programs.nixvim = {
        extraPlugins = [ stickybuf ];

        extraConfigLua = ''
          require("stickybuf").setup()
          '';
      };
    };
}
