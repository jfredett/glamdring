{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:pta2002/nixvim/nixos-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eclib = {
      url = "git+file:/home/jfredett/code/eclib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, nixvim, ... }: flake-utils.lib.eachDefaultSystem (system: let
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
            home-manager.users.jfredett = import ./jfredett.nix { inherit pkgs lib nixvim; config = {}; };
            home-manager.users.pinky = import ./pinky.nix { inherit pkgs lib nixvim; config = {}; };
          }
        ];
      };

      archimedes = hwConfig: nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [ 
      	  hwConfig
      	  (import ./common.nix)
          home-manager.nixosModules.home-manager
          {
            system.stateVersion = "23.05";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jfredett = import ./jfredett.nix { inherit pkgs lib nixvim; config = {}; };
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
