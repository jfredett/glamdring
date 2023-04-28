{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:pta2002/nixvim";
    eclib.url = "git+file:/home/jfredett/code/eclib";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, eclib, nixvim, ... }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    mkHome = home-manager.lib.homeManagerConfiguration;
  in with nixpkgs.lib; {
    devShell = pkgs.mkShell {
      packages = with pkgs; [
        ruby_3_1
        rake

        lua-language-server
      ];
    };

    nixosConfigurations = let 
      emerald-city = eclib.lib.${system};
    in {
      randy = hwConfig: nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [ 
          hwConfig
          emerald-city.common
          emerald-city.vm
          home-manager.nixosModules.home-manager
          {
            system.stateVersion = "23.05";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jfredett = import ./jfredett.nix;
            home-manager.users.pinky = import ./pinky.nix { inherit pkgs lib nixvim; config = {}; };
          }
        ];
      };
    };

    homeConfigurations = {
      randy = mkHome {
        inherit pkgs; 

        modules = [
          ./home.nix
          {
            home = {
              username = "jfredett";
              homeDirectory = "/home/jfredett";
            };
          }
        ];
      };

      work = mkHome {
        inherit pkgs; 

        modules = [
          ./home.nix
          {
            home = {
              username = "jfredette";
              homeDirectory = "/Users/jfredette";
            };
          }
        ];
      };
    };
  });
}
