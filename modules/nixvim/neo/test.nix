{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.neo.test = {
      enable = mkEnableOption "Enable the neotest plugin";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.neo.test;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        neotest
      ];

      plugins.neotest = {
        enable = true;

        adapters = {
          rust = {
            enable = true;
          };
          bash.enable = true;
          rspec = {
            enable = true;
          };
        };
      };

      keymaps = [
        {
          # Open Summary Panel
          mode = "n";
          key = "<leader>t<space>";
          action = ":Neotest summary<CR>";
        }
        {
          # Run test under cursor
          mode = "n";
          key = "<leader>r<space>";
          action = ":Neotest run<CR>";
        }
        {
          # Rerun previous test
          mode = "n";
          key = "<leader>rr<space>";
          action = ":Neotest run last<CR>";
        }
        {
          # run tests in file
          mode = "n";
          key = "<leader>rf<space>";
          action = ":Neotest run file<CR>";
        }

      ];
    };
  };
}
