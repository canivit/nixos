{ pkgs, config, ... }:
let
  cursorSize = if config.modules.hidpi.enable then 48 else 24;
in
{
  environment.systemPackages = with pkgs; [
    dconf
    adwaita-icon-theme
  ];

  programs.dconf.enable = true;
  services.gnome.at-spi2-core.enable = true;

  home-manager.users.can.gtk = {
    enable = true;

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      package = pkgs.open-sans;
      name = "Open Sans Regular";
      size = 12;
    };

    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = cursorSize;
    };
  };
}
