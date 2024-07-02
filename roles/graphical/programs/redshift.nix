{ ... }:
{
  home-manager.users.can.services.redshift = {
    enable = true;
    provider = "manual";
    dawnTime = "6:00-8:00";
    duskTime = "19:30-21:00";
    tray = true;
    temperature = {
      day = 6500;
      night = 2500;
    };
  };
}
