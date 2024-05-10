{ ... }:
{
  home-manager.users.can.services.redshift = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    temperature = {
      day = 6500;
      night = 2500;
    };
  };

  services.geoclue2.enable = true;
}
