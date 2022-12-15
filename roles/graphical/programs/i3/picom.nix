{ ... }:
{
  home-manager.users.can.services.picom = {
    backend = "glx";
    enable = true;
    shadow = false;
    shadowExclude = [
      "class_g = 'Polybar'"
      "class_g = 'slop'"
    ];
    fade = true;
    fadeDelta = 2;
    settings = { 
      "xinerama-shadow-crop" = true;
      "shadow-exclude-reg" = "x30+0+0";
    };
    vSync = true;
  };
}
