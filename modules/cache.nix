{ lib, config, pkgs, ... }:
let cfg = config.modules.cache; in {
  options.modules.cache.enable = lib.mkEnableOption "cachix cache";

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [
        "https://canivit.cachix.org"
      ];
      trusted-public-keys = [
        "canivit.cachix.org-1:oqZfaVHqqURB1CjMm5ZFUt/oYI1LvIpFp1VSG1U9tG0="
      ];
    };
    environment.systemPackages = with pkgs; [
      cachix
    ];
  };
}
