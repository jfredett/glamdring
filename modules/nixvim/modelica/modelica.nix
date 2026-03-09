# This is busted because building openmodelica is busted, that's busted because it relies on QT stuff that's insecure.
{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.modelica = {
      enable = mkEnableOption "Enable support for the modelica modeling toolkit";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.modelica;
    condition = cfg.enable;
  in mkIf condition {
      home.packages = with pkgs; with openmodelica ; [
        # omcompiler
        # omsimulator
        # omplot
        # omparser
        # omedit -- I don't need the editor, I _am_ the editor
        # omlibrary
        # omshell
      ];

      programs.nixvim = {
        extraPlugins = [
          # lsp, treesitter, etc
        ];

        # config
      };
  };
}
