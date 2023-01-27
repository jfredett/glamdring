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
      linux = "x86_64-linux";
      mac = "aarch64";
      pkgs = nixpkgs.legacyPackages.${system};

      jfredett = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };

      defaultShell =  pkgs.mkShell {
        packages = with pkgs; [ 
          ruby_3_1
          rake
        ];
      };
    in {
      homeConfigurations.jfredett = jfredett;
      homeConfigurations.jfredette = jfredett;
      homeConfigurations.fredettej = jfredett;

      devShells.${linux}.default = defaultShell;  
      devShells.${mac}.default = defaultShell;   
    };
}