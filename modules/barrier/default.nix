{ config, lib, pkgs, ... }: with lib; {
  options.glamdring.barrier = {
    enable = mkEnableOption "Enable Barrier";
    server = mkOption {
      type = types.str;
    };
    debugLevel = mkOption {
      type = types.str;
      default = "INFO";
    };
  };

  config = let
    cfg = config.glamdring.barrier;
    isWayland = config.glamdring.hyprland.enable;
    barrierBasedCfg = mkIf (!isWayland) {
      home.packages = with pkgs; [ barrier ];

      systemd.user.services.barrier-client = {
        Unit = {
          Description = "Barrier Client Service";
          After = [ "network.target" ];
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
        Service = {
          ExecStart = with pkgs; writeShellScript "barrier-client-login.sh" ''
            #!/run/current-system/sw/bin/bash
            ${pkgs.barrier}/bin/barrierc --disable-crypto --display :0 --debug ${cfg.debugLevel} -f ${cfg.server}
          '';
          Restart = "always";
        };
      };
    };
    waynergyBasedCfg = mkIf isWayland {
      home.packages = with pkgs; [ waynergy wl-clipboard ];

      home.file.".config/waynergy/config.ini" = {
        text = ''
          xkb_key_offset = 7
        '';
      };

      home.file.".config/waynergy/xkb_keymap" = {
        text = ''
        xkb_keymap {
          xkb_keycodes { include "mac+aliases(qwerty)" };
          xkb_types  { include "complete" };
          xkb_compat { include "complete" };
          xkb_symbols { include "pc+us+inet(evdev)" };
          xkb_geometry { include "pc(pc105)" };
        };
        '';
      };

      home.file.".config/xkb/keycodes/mac" = {
        text = ''
        //Set waynergy config `xkb_key_offset` to 7
        default xkb_keycodes "mac" {
          minimum  = 8;
          maximum  = 255;
          <ESC>  = 61;
          <FK01>  = 130;
          <FK02>  = 128;
          <FK03>  = 107;
          <FK04>  = 126;
          <FK05>  = 104;
          <FK06>  = 105;
          <FK07>  = 106;
          <FK08>  = 108;
          <FK09>  = 109;
          <FK10>  = 117;
          <FK11>  = 111;
          <FK12>  = 119;
          <TLDE>  = 58;
          <AE01>  = 26;
          <AE02>  = 27;
          <AE03>  = 28;
          <AE04>  = 29;
          <AE05>  = 31;
          <AE06>  = 30;
          <AE07>  = 34;
          <AE08>  = 36;
          <AE09>  = 33;
          <AE10>  = 37;
          <AE11>  = 35;
          <AE12>  = 32;
          <BKSP>  = 59;
          <TAB>  = 56;
          <AD01>  = 20;
          <AD02>  = 21;
          <AD03>  = 22;
          <AD04>  = 23;
          <AD05>  = 25;
          <AD06>  = 24;
          <AD07>  = 40;
          <AD08>  = 42;
          <AD09>  = 39;
          <AD10>  = 43;
          <AD11>  = 41;
          <AD12>  = 38;
          <BKSL>  = 50;
          <CAPS>  = 65;
          <AC01>  = 8;
          <AC02>  = 9;
          <AC03>  = 10;
          <AC04>  = 11;
          <AC05>  = 13;
          <AC06>  = 12;
          <AC07>  = 46;
          <AC08>  = 48;
          <AC09>  = 45;
          <AC10>  = 49;
          <AC11>  = 47;
          <RTRN>  = 44;
          <LFSH>  = 64;
          <AB01>  = 14;
          <AB02>  = 15;
          <AB03>  = 16;
          <AB04>  = 17;
          <AB05>  = 19;
          <AB06>  = 53;
          <AB07>  = 54;
          <AB08>  = 51;
          <AB09>  = 55;
          <AB10>  = 52;
          <LALT>  = 66;
          <LCTL>  = 67;
          <SPCE>  = 57;
          <LWIN>  = 63;
          <UP>  = 134;
          <LEFT>  = 131;
          <DOWN>  = 133;
          <RGHT>  = 132;
          <MENU>  = 118;
          <PRSC>  = 113;
          <SCLK>  = 115;
          <PAUS>  = 121;
          <INS>   = 122;
          <DELE>  = 125;
          <HOME>  = 123;
          <END>   = 127;
          <PGUP>  = 124;
          <PGDN>  = 129;
          <NMLK>  = 79;
          <KPDV>  = 83;
          <KPMU>  = 75;
          <KPSU>  = 86;
          <KP7>   = 97;
          <KP8>   = 99;
          <KP9>   = 100;
          <KPAD>  = 77;
          <KP4>   = 94;
          <KP5>   = 95;
          <KP6>   = 96;
          <KP1>   = 91;
          <KP2>   = 92;
          <KP3>   = 93;
          <KPEN>  = 84;
          <KP0>   = 90;
          <KPDL>  = 73;
        };
        '';

      };

      systemd.user.services.waynergy-client = {
        Unit = {
          Description = "Waynergy Client Service";
          After = [ "network.target" ];
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
        Service = {
          ExecStart = with pkgs; writeShellScript "waynergy-client-login.sh" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.waynergy}/bin/waynergy -c ${cfg.server} -L ${cfg.debugLevel}
          '';
          Restart = "always";
        };
      };
    };
  in builtins.trace "Deprecated, use Deskflow instead" (mkIf cfg.enable (mkMerge [ barrierBasedCfg waynergyBasedCfg ]));
}
