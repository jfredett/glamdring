{ config, pkgs, lib, nur, ... }: with lib; {
  imports = [
    ./lualine.nix
  ];

  options.glamdring.nixvim.statusline = mkOption {
    default = "lualine";
    type = types.enum [ "lualine" ];
    description = "The statusline to use";
  };
}

