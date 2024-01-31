{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:pta2002/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nur, nix-darwin, home-manager, flake-utils, nixvim, ... }:
  let
    system = "x86_64-linux";
    homeManagerConfFor = config:
      { ... }: {
        imports = [ 
          nixvim.homeManagerModules.nixvim
          nur.hmModules.nur
          config 
        ];
      };
    nixosConfFor = configs: nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        { system.stateVersion = "23.05"; }
        (import ./common.nix)
        home-manager.nixosModules.home-manager
      ] ++ configs;

      specialArgs = { inherit nixpkgs; };
    };
  in {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; config = {}; };
    in pkgs.mkShell { buildInputs = []; };

    nixosConfigurations = {
      archimedes = configs: nixosConfFor ([
        ./hosts/archimedes/hardware-configuration.nix
        ./1password.nix
        ./virtualbox.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jfredett = homeManagerConfFor ./jfredett.nix;
        }
      ] ++ configs);
    };

    darwinConfigurations."MBP-G071LCCXRH" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        { 
          system.stateVersion = 4; 
          services.nix-daemon.enable = true;
        }
        (import ./common.nix)
        home-manager.darwinModules.home-manager
        {
          users.users.jfredette.home = "/Users/jfredette";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jfredette = homeManagerConfFor ./jfredett.nix;
        }
      ];

      specialArgs = { inherit nixpkgs; };
    };

  };
}
