{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dconf
    gnome.adwaita-icon-theme
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
      name = "ePapirus-Dark";
    };

    font = {
      package = pkgs.open-sans;
      name = "Open Sans Regular";
      size = 12;
    };

    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size= 48;
    };
  };
}
