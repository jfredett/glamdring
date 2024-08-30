{ config, lib, pkgs, ...}: with lib; {
  options.glamdring.bash.aliases.azure = with types; {
    enable = mkEnableOption "enable azure aliases";
  };

  config = let 
    cfg = config.glamdring.bash.aliases.azure;
  in mkIf cfg.enable {
    programs.bash = let
      # TODO: More calculation on this triple, encode the naming convention
      getContext = {rg, name, subscription}:
        "az aks get-credentials --resource-group ${rg} --name ${name} --subscription sb-mcd-${subscription} --overwrite-existing";
      getSSH = {rg, name, subscription}:
        "az ssh config --resource-group ${rg} --name ${name} --subscription ${subscription} --file ${subscription}-${name} --overwrite-existing";
    in {
      shellAliases = {
        # AKS clusters
        "dev-aks" = getContext {
          rg = "mcd-dev-eastus-aks";
          name = "mcd-dev-eastus-akscluster1";
          subscription = "dev";
        };
        "stg-aks" = getContext {
          rg = "mcd-stg-eastus-aks";
          name = "mcd-stg-eastus-akscluster1";
          subscription = "prd";
        };
        "beta-aks" = getContext {
          rg = "mcd-beta-eastus-aks";
          name = "mcd-beta-eastus-akscluster1";
          subscription = "prd";
        };
        "dr-aks" = getContext {
          rg = "mcd-dr-westus-aks";
          name = "mcd-dr-westus-akscluster1";
          subscription = "prd";
        };
        "prod-aks" = getContext {
          rg = "mcd-prd-eastus-aks";
          name = "mcd-prd-eastus-akscluster1";
          subscription = "prd";
        };
      };
    };
  };
}
