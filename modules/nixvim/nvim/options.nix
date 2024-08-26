{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {
      globals.mapleader = ",";

      opts = {
        number = true;
        relativenumber = false;
        incsearch = true;
        backup = false;
        writebackup = false;
        swapfile = false;
        wildmenu = true;
        shortmess = "aIA";
        # Show loose whitespace
        list = true;

        # 2 spaces is more than enough for a tab, and never use \t.
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;

        # 3x100 = 15 characters shy of a max width 1440p screen for me.
        # which means exactly 3 columns of text before wrapping.
        textwidth = 100;
      };

      /* From the Neovim Manual

      Overview of which map command works in which mode.  More details below.
      COMMANDS                    MODES ~
      :map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
      :nmap  :nnoremap :nunmap    Normal
      :vmap  :vnoremap :vunmap    Visual and Select
      :smap  :snoremap :sunmap    Select
      :xmap  :xnoremap :xunmap    Visual
      :omap  :onoremap :ounmap    Operator-pending
      :map!  :noremap! :unmap!    Insert and Command-line
      :imap  :inoremap :iunmap    Insert
      :lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
      :cmap  :cnoremap :cunmap    Command-line
      :tmap  :tnoremap :tunmap    Terminal-Job

      Same information in a table:
      *map-table*
      Mode           | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
      Command        +------+-----+-----+-----+-----+-----+------+------+
      [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
      n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
      [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
      i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
      c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
      v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
      x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
      s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
      o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
      t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
      l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |

      */

      keymaps = let
      # TODO: These have terrible names.
      mkSilentLeaderLeader = cmd: action: {
        action = "<cmd>${action}<cr>";
        key = "<leader>${cmd}<leader>";
        options = { silent = true; };
        mode = "n";
      };
      mkSilentLeaderSpace = cmd: action: {
        action = "<cmd>${action}<cr>";
        key = "<leader>${cmd}<space>";
        options = { silent = true; };
        mode = "n";
      };
      mkCmd = cmd: action: {
        action = "<cmd>${action}<cr>";
        key = cmd;
        options = { silent = false; };
      };
      mkTerminal = cmd: action: {
        action = action;
        key = cmd;
        options = { silent = true; };
        mode = "t";
      };
      in [
        (mkSilentLeaderSpace "d" "Telescope find_files")
        (mkSilentLeaderLeader "b" "Telescope buffers")
        (mkSilentLeaderLeader "h" "Telescope help_tags")
        (mkSilentLeaderLeader "d" "Neotree")
        (mkSilentLeaderLeader "g" "Neogit")
        (mkCmd "Y" "y$")
        (mkCmd "<C-S>" "<C-A>")
        (mkCmd "W" "w")
        (mkCmd "Wq" "wq")
        (mkCmd "Q" "q")
        (mkCmd "WQ" "wq")
        (mkTerminal "<Esc>" "<C-\\><C-n>")
      ];
    };
  };
}
