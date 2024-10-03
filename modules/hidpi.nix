{ lib, config, ... }:
let cfg = config.modules.hidpi; in {
  options.modules.hidpi.enable = lib.mkEnableOption "hidpi";

  config = lib.mkIf cfg.enable { };
}
