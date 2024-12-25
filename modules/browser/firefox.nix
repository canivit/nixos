{ lib, config, pkgs, ... }:
let cfg = config.modules.browser.firefox; in {
  options.modules.browser.firefox = {
    enable = lib.mkEnableOption "enable firefox web browser";
    default = lib.mkEnableOption "set firefox as default browser";
  };

  config = lib.mkIf cfg.enable {
    modules.browser.default = lib.mkIf cfg.default {
      cmd = "firefox-developer-edition";
      desktop = "firefox-developer-edition.desktop";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition-bin;
    };
  };
}
