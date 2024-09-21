## TODO: Rebuild this so there is a library that is used and available to all nixvim related things,
#it should create a table of bindings and then create all the bindings in one big chunk. That way I
#can store bindings with the associated configuration. Something like glamdring.nixvim.keybinds = [
#list of binds ]
{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {

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

      # FIXME: I need to refactor this to some better system. I don't know if Nixvim has something,
      # but I want to ultimately be able to inject these from the modules, and ideally there is some
      # library that creates these guys that the module can rely on.
      keymaps = let
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
      mkInsertCmd = cmd: action: {
        action = "${action}";
        key = cmd;
        options = { silent = true; };
        mode = "i";
      };
      mkCmd = cmd: action: {
        action = "${action}";
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
        (mkSilentLeaderLeader "c" "source ~/.config/nvim/init.lua")
        {
          action = "gc";
          key = "<leader>c<space>";
          mode = [ "n" "o" "x" ];
          options = { remap = true; };
        }
        (mkSilentLeaderSpace "d" "Telescope find_files")
        (mkSilentLeaderLeader "b" "Telescope buffers")
        (mkSilentLeaderLeader "h" "Telescope help_tags")
        (mkSilentLeaderLeader "d" "Neotree")
        (mkSilentLeaderLeader "g" "Neogit")
        (mkSilentLeaderLeader "b" "Gitblame")
        (mkSilentLeaderLeader "q" "copen")
        (mkCmd "Y" "y$")
        (mkCmd "<C-S>" "<C-A>")
        (mkCmd "W" "w")
        (mkCmd "Wq" "wq")
        (mkCmd "Q" "q")
        (mkCmd "WQ" "wq")
        (mkTerminal "<F12>" "<C-\\><C-n>")
        (mkTerminal "<C-w>" "<C-\\><C-n><C-w>")
        (mkCmd "<F12>" "<Esc>")
        (mkInsertCmd "<F12>" "<Esc>")
        # TODO: Limit these to the 'octo' filetype
        # (mkInsertCmd "@" "@<C-x><C-O>")
        # (mkInsertCmd "#" "#<C-x><C-O>")
      ];
    };
  };
}
