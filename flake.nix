{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
#      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nur, nix-darwin, home-manager, flake-utils, nixvim, ... }:
  let
    system = "x86_64-linux";
    homeManagerConfFor = config: { ... }: {
      imports = [
        nixvim.homeManagerModules.nixvim
        nur.hmModules.nur
        config
      ];
    };
    nixosConfFor = configs: nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        { system.stateVersion = "24.05"; }
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
      ] ++ configs;

      specialArgs = { inherit nixpkgs nur nixvim home-manager; };
    };
  in {
    # Dev Shells:

    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; config = {}; };
    in pkgs.mkShell { buildInputs = []; };

    devShells.aarch64-darwin.default = let
      pkgs = import nixpkgs { system = "aarch64-darwin"; config = {}; };
    in pkgs.mkShell { buildInputs = [ pkgs.git ]; };

    # Modules
    nixosModules = {
      glamdring.home-manager = import ./modules { inherit inputs; };
      glamdring.nixos = import ./nixos { inherit inputs; };
    };

    homeConfigurations = {
      jfredett = homeManagerConfFor ./jfredett.nix;
      media = homeManagerConfFor ./media.nix;
    };

    # Machine Configurations:
    nixosConfigurations = {
      maiasaura = configs: nixosConfFor ([
        ./hosts/maiasaura
        ./nixos
        {
          glamdring._1password = {
            enable = true;
            withGUI = true;
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.media = homeManagerConfFor ./media.nix;
        }
      ] ++ configs);

      archimedes = configs: nixosConfFor ([
        ./hosts/archimedes
        ./nixos
        {
          glamdring.virtualbox.enable = true;
          glamdring._1password = {
            enable = true;
            withGUI = true;
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jfredett = homeManagerConfFor ./jfredett.nix;
        }
      ] ++ configs);
    };

    darwinConfigurations = {
      "MBP-G071LCCXRH" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { 
            system.stateVersion = 4; 
            services.nix-daemon.enable = true;
          }
          home-manager.darwinModules.home-manager
          {
            users.users.jfredette.home = "/Users/jfredette";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jfredette = homeManagerConfFor ./work.nix;
          }
        ];

        specialArgs = { inherit nixpkgs nur; };
      };
      "Hedges" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { 
            system.stateVersion = 4;
            services.nix-daemon.enable = true;
          }
          home-manager.darwinModules.home-manager
          {
            users.users.jfredett.home = "/Users/jfredett";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jfredett = homeManagerConfFor ./jfredett.nix;
          }
        ];

        specialArgs = { inherit nixpkgs; };
      };
    };
  };
}
