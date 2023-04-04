{ ... }:
{
  home-manager.users.can.services.picom = {
    backend = "glx";
    enable = true;
    shadow = false;
    shadowExclude = [
      "class_g = 'Polybar'"
      "class_g = 'slop'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
    fade = true;
    fadeDelta = 2;
    settings = {
      "xinerama-shadow-crop" = true;
      "shadow-exclude-reg" = "x30+0+0";
    };
    vSync = true;
    opacityRules = [
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
  };
}
