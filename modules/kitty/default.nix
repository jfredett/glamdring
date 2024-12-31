{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.kitty = {
      enable = mkEnableOption "Enable the kitty terminal emulator";
      stylix.enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Enable the Stylix theme for kitty.
        '';
      };
    };
  };

  config = let
    cfg = config.glamdring.kitty;
    condition = cfg.enable;
  in mkIf condition {
      #stylix.targets.kitty.enable = cfg.stylix.enable;

      home.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font Mono" ];
        };
      };

      programs.kitty = {
        enable = true;
        shellIntegration.enableBashIntegration = true;

        font = lib.mkForce {
          name = "JetBrainsMono Nerd Font Mono";
          package = pkgs.nerd-fonts.jetbrains-mono;
          size = if std.isLinux then 12 else 16;
        };

        extraConfig = ''
          # kitty.conf

          enable_audio_bell no
          visual_bell_color none
          visual_bell_duration 0.0

          ## Font Stuff

          bold_font         family="JetBrainsMono Nerd Font Mono" style=Bold
          italic_font       family="JetBrainsMono Nerd Font Mono" style=Italic
          bold_italic_font  family="JetBrainsMono Nerd Font Mono" style="ExtraBold Italic"


          ## Keymaps

          map ctrl+shift+c copy_to_clipboard
          map cmd+c copy_to_clipboard

          map ctrl+shift+v paste_from_clipboard
          map cmd+v paste_from_clipboard

          map ctrl+shift+z scroll_to_prompt -1
          map cmd+shift+z scroll_to_prompt -1

          map ctrl+shift+x scroll_to_prompt 1
          map cmd+shift+x scroll_to_prompt 1
        '';
      };
    };
}
