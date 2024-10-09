{ lib, config, pkgs, ... }:
let cfg = config.modules.browser.brave; in {
  options.modules.browser.brave = {
    enable = lib.mkEnableOption "enable brave web browser";
    default = lib.mkEnableOption "set brave as default browser";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.brave ];
    modules.browser.default = lib.mkIf cfg.default {
      cmd = "brave";
      desktop = "brave-browser.desktop";
    };
  };
}
