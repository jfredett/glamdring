{ config, lib, pkgs, ... }: {
  options = {
    glamdring.alacritty.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Alacritty terminal emulator";
    };
  };

  config = lib.mkIf config.glamdring.alacritty.enable {

    home.packages = [ pkgs.nerd-fonts.inconsolata ];

    programs.alacritty = {
      enable = true;
      settings = {
        window = {
        dimensions = {
          columns = 80;
          lines = 24;
        };
        /*
        decorations = "None";
        decorations_theme_variant = "None";
        */
        startup_mode = "Windowed";

        padding = {
          x = 0;
          y = 0;
        };
      };

      /*
      font = {
        normal = {
          family = "Inconsolata Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Inconsolata Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Inconsolata Nerd Font";
          style = "Italic";
        };
        size = 11.0;
        builtin_box_drawing = true;

        offset = {
          x = 0;
          y = 0;
        };
      };
      */

      /*
      keybinds = [
        { key = "c"      ; mods = "Control"       ; action = "Copy"             ; }
        { key = "v"      ; mods = "Control"       ; action = "Paste"            ; }
        { key = "Key0"   ; mods = "Control|Shift" ; action = "ResetFontSize"    ; }
        { key = "Equals" ; mods = "Command|Shift" ; action = "IncreaseFontSize" ; }
        { key = "Minus"  ; mods = "Command|Shift" ; action = "DecreaseFontSize" ; }
      ];
      */
    };
  };
};
}
