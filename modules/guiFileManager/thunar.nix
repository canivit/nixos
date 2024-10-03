{ lib, config, pkgs, ... }:
let cfg = config.modules.guiFileManager.thunar; in {
  options.modules.guiFileManager.thunar.enable = lib.mkEnableOption "thunar file manager";

  config = lib.mkIf cfg.enable {
    modules.guiFileManager.cmd = "thunar";
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    programs.xfconf.enable = true; #save preferences
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
  };
}
