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
      package = pkgs.yaru-theme;
      name = "Yaru-blue-dark";
    };

    iconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru-blue-dark";
    };

    font = {
      package = pkgs.open-sans;
      name = "Open Sans Regular";
      size = 12;
    };

    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size= 24;
    };
  };
}
