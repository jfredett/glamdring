{
  description = "Glamdring, a weapon fit for a wizard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = {
        linux = "x86_64-linux";
        mac = "aarch64-darwin";
      };

      defaultShell = system: let 
        pkgs = nixpkgs.legacyPackages.${system};
      in pkgs.mkShell {
        packages = with pkgs; [ 
          ruby_3_1
          rake
        ];
      };
      
      mkHome = { system, user, home }: {
        ${user} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${systems.${system}};

          modules = [
             ./home.nix 
             {
               home = {
                 username = user;
                 homeDirectory = home;
               };
             }
          ];
        };
      };
    in {
      defaultPackage.${systems.linux} = home-manager.defaultPackage.${systems.linux};
      defaultPackage.${systems.mac} = home-manager.defaultPackage.${systems.mac};

      homeConfigurations = mkHome {
        user = "jfredette";
        home = "/Users/jfredette";
        system = "mac";
      } // mkHome {
        user = "jfredett";
        home = "/home/jfredett";
        system = "linux";
      };
      /*
        "jfredette" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${systems.mac};

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
        "jfredett" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${systems.linux};

          modules = [ ./linux.nix ];
        };
      };
      */

      devShells.${systems.linux}.default = defaultShell systems.linux;  
      devShells.${systems.mac}.default = defaultShell systems.mac;   
    };
}