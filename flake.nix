{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nur, nix-darwin, home-manager, flake-utils, nixvim, stylix, hyprland, ... }:
  let
    homeManagerConfFor = config: { ... }: {
      imports = [
        nixvim.homeManagerModules.nixvim
        nur.hmModules.nur
        stylix.homeManagerModules.stylix config
      ];
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
    };

    homeConfigurations = {
      jfredett = homeManagerConfFor ./jfredett.nix;
      media = homeManagerConfFor ./media.nix;
    };

    darwinConfigurations = let 
      pkgs = import nixpkgs { system = "aarch64-darwin"; config = {}; };
    in {
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
          { 
            environment.systemPackages = [ pkgs.mosh ];
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
