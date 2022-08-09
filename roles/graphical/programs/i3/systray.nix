{ ... }:
{
  services.blueman.enable = true;
  home-manager.users.can.services = {
    #blueman-applet.enable = true;
    #network-manager-applet.enable = true;
    #pasystray.enable = true;
  };
}
