{ ... }:
{
  home-manager.users.can.programs.rofi = {
    enable = true;
    font = "Open Sans 12";
    theme = "Arc-Dark";
    extraConfig = {
      modi = "window,run,drun";
    };
  };
}
