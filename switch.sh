export NIXPKGS_ALLOW_UNFREE=1
# nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake . --impure $@
darwin-rebuild switch --impure --flake '.#'
