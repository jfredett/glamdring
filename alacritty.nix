{ config, lib, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # Ignore this since we're operating in Awesome anyway
        dimensions = {
          columns = 0;
          lines = 0;
        };
        decorations = "None";
        decorations_theme_variant = "None";
        startup_mode = "Windowed";

        padding = {
          x = 0;
          y = 0;
        };
      };
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
        size = 14.0;
        builtin_box_drawing = true;

        offset = {
          x = 0;
          y = 0;
        };
      };
      keybinds = [
        { key = "c"      ; mods = "Control" ; action = "Copy"             ; }
        { key = "v"      ; mods = "Control" ; action = "Paste"            ; }
	{ key = "Key0"   ; mods = "Control|Shift" ; action = "ResetFontSize"    ; }
	{ key = "Equals" ; mods = "Command|Shift" ; action = "IncreaseFontSize" ; }
	{ key = "Minus"  ; mods = "Command|Shift" ; action = "DecreaseFontSize" ; }
  
      ];
    };
  };
}
