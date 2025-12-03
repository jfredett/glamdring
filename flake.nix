{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";

    mac-app-util.url = "github:hraban/mac-app-util";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    ags.url = "github:Aylur/ags";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    nixvim = {
      url = "github:jfredett/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self,
    flake-utils,
    ghostty,
    home-manager,
    hyprland,
    mac-app-util,
    neovim-nightly-overlay,
    nix-darwin,
    nixpkgs,
    nixvim,
    nur,
    ... }:
    let
      homeManagerConfFor = config: { ... }: {
        imports = [
          nixvim.homeModules.nixvim
          nur.modules.homeManager.default
          config
          {
            nixpkgs.overlays = [
              neovim-nightly-overlay.overlays.default
              nur.overlays.default
              ghostty.overlays.default
            ];
          }
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

      homeConfigurations = rec {
        dragon = homeManagerConfFor ./dragon.nix;
        hyprland = homeManagerConfFor ./hyprland.nix;
        jfredett = builtins.trace "Deprecated: Use `standard` instead" standard;
        media = homeManagerConfFor ./media.nix;
        minimal = homeManagerConfFor ./minimal.nix;
        standard = homeManagerConfFor ./standard.nix;
        work = homeManagerConfFor ./work.nix;
      };

      darwinConfigurations = let
        pkgs = import nixpkgs { system = "aarch64-darwin"; config = {}; };
        glamdringForDarwin = import ./modules/darwin.nix;
        mkDarwinSystem = config: nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          specialArgs = { inherit nixpkgs nur; };

          modules = [
            mac-app-util.darwinModules.default
            glamdringForDarwin
            {
              system.stateVersion = 4;
            }
            home-manager.darwinModules.home-manager
            config
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
            }
            {
              environment.systemPackages = [ pkgs.mosh ];
            }
          ];
        };
      in {
        "MBP-G071LCCXRH" = mkDarwinSystem {
          users.users.jfredette.home = "/Users/jfredette";
          home-manager.users.jfredette = homeManagerConfFor ./work.nix;
          environment.systemPackages = [ pkgs.mosh ];
        };

        "Hedges" = mkDarwinSystem {
          users.users.jfredett.home = "/Users/jfredett";
          home-manager.users.jfredett = homeManagerConfFor ./mac.nix;
        };
      };
    };
}
