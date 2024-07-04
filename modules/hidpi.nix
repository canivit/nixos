{ lib, config, ... }:
let cfg = config.hidpi; in {
  options = {
    hidpi.enable = lib.mkEnableOption "hidpi";
  };

  config = lib.mkIf cfg.enable { };
}
