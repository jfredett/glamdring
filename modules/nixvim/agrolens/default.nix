{ config, lib, pkgs, ... }: with lib; let
  agroLens = pkgs.vimUtils.buildVimPlugin {
    pname = "agrolens.nvim";
    version = "v2.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "desdic";
      repo = "agrolens.nvim";
      rev = "3c7d7e943f5128473f70f45b53b57893ebb5cc84"; # SHA of the commit to build.
      sha256 = "sha256-+deBOCq00O1EVS+fPughVRYlbEjEndQl2DbYQ66dQF0=";
    };
  };
in {
  options = with types; {
    glamdring.nixvim.agrolens = {
      enable = mkEnableOption "Enable agrolens";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.agrolens;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      extraPlugins = [ agroLens ];
      extraConfigLua = ''
        require "telescope".load_extension("agrolens")
        require("telescope").extensions = {
          agrolens = {
            debug = false,
            same_type = true,
            include_hidden_buffers = false,
            disable_indentation = false,
            aliases = {

            }
          }
        }
      '';
      # TODO: Keybinds + Options for other plugins to add agrolens keybinds.
    };
    
  };
}
