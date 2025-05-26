{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.auto-upgrade;
in
{

  options.modules.auto-upgrade = {
    enable = lib.mkEnableOption "enable auto upgrade from flake";
  };

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "github:canivit/nixos";
      allowReboot = true;
      dates = "02:00";
      rebootWindow = {
        lower = "02:00";
        upper = "06:00";
      };
    };
  };
}
