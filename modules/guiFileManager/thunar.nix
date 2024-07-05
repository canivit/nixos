{ lib, config, pkgs, ... }:
let cfg = config.guiFileManager.thunar; in {
  options = {
    guiFileManager.thunar.enable = lib.mkEnableOption "thunar file manager";
  };

  config = lib.mkIf cfg.enable {
    guiFileManager.cmd = "thunar";
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
